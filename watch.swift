import Foundation
#if canImport(Network)
import Network
#endif

// ANSI color codes for terminal output
enum ConsoleColor: String {
    case reset = "\u{001B}[0m"
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case cyan = "\u{001B}[36m"
}

// Helper to print colored messages
func printColored(_ message: String, color: ConsoleColor, bold: Bool = false) {
    let boldCode = bold ? "\u{001B}[1m" : ""
    print("\(color.rawValue)\(boldCode)\(message)\(ConsoleColor.reset.rawValue)")
}

// Paths to monitor
let paths = ["Application/Sources", "Notes.playground"]
let fileManager = FileManager.default
let pollingInterval = 1.0 // Seconds between checks
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

// Function to get all files in a directory recursively
func getFiles(in directory: String) -> [String] {
    guard let enumerator = fileManager.enumerator(atPath: directory) else {
        printColored("⚠️  Warning: Could not enumerate directory \(directory)", color: .yellow)
        return []
    }
    var files: [String] = []
    while let file = enumerator.nextObject() as? String {
        files.append((directory as NSString).appendingPathComponent(file))
    }
    return files
}

// Function to get the modification date of a file
func modificationDate(for file: String) -> Date? {
    do {
        let attributes = try fileManager.attributesOfItem(atPath: file)
        return attributes[.modificationDate] as? Date
    } catch {
        printColored("⚠️  Error accessing modification date for \(file): \(error)", color: .yellow)
        return nil
    }
}

// Simple HTTP server for serving static files
class SimpleHTTPServer {
    private let port: UInt16
    private let documentRoot: String
    private var listener: NWListener?
    
    init(port: UInt16, documentRoot: String) {
        self.port = port
        self.documentRoot = documentRoot
    }
    
    func start() {
        #if canImport(Network)
        let parameters = NWParameters.tcp
        parameters.allowLocalEndpointReuse = true
        
        do {
            listener = try NWListener(using: parameters, on: NWEndpoint.Port(rawValue: port)!)
            listener?.newConnectionHandler = { connection in
                self.handleConnection(connection)
            }
            listener?.start(queue: .global())
            printColored("🌐 HTTP Server started on http://localhost:\(port)", color: .green, bold: true)
            printColored("📁 Serving files from: \(documentRoot)", color: .blue)
        } catch {
            printColored("❌ Failed to start HTTP server: \(error)", color: .red)
        }
        #else
        printColored("❌ Network framework not available", color: .red)
        #endif
    }
    
    #if canImport(Network)
    private func handleConnection(_ connection: NWConnection) {
        connection.start(queue: .global())
        
        connection.receive(minimumIncompleteLength: 1, maximumLength: 8192) { data, _, isComplete, error in
            if let data = data, let request = String(data: data, encoding: .utf8) {
                self.processRequest(request, connection: connection)
            }
            
            if isComplete || error != nil {
                connection.cancel()
            }
        }
    }
    
    private func processRequest(_ request: String, connection: NWConnection) {
        let lines = request.components(separatedBy: "\r\n")
        guard let requestLine = lines.first else { return }
        
        let components = requestLine.components(separatedBy: " ")
        guard components.count >= 2 else { return }
        
        let method = components[0]
        var path = components[1]
        
        if method != "GET" {
            sendResponse(connection: connection, statusCode: 405, body: "Method Not Allowed")
            return
        }
        
        if path == "/" {
            path = "/index.html"
        }
        
        // Handle pretty URLs - try appending .html if file doesn't exist
        var filePath = documentRoot + path
        
        if !FileManager.default.fileExists(atPath: filePath) && !path.hasSuffix(".html") {
            let htmlPath = documentRoot + path + ".html"
            if FileManager.default.fileExists(atPath: htmlPath) {
                filePath = htmlPath
            }
        }
        
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let mimeType = getMimeType(for: filePath)
                sendFileResponse(connection: connection, data: fileData, mimeType: mimeType)
            } catch {
                sendResponse(connection: connection, statusCode: 500, body: "Internal Server Error")
            }
        } else {
            sendResponse(connection: connection, statusCode: 404, body: "Not Found")
        }
    }
    
    private func getMimeType(for path: String) -> String {
        let ext = (path as NSString).pathExtension.lowercased()
        switch ext {
        case "html", "htm":
            return "text/html"
        case "css":
            return "text/css"
        case "js":
            return "application/javascript"
        case "json":
            return "application/json"
        case "png":
            return "image/png"
        case "jpg", "jpeg":
            return "image/jpeg"
        case "gif":
            return "image/gif"
        case "svg":
            return "image/svg+xml"
        case "ico":
            return "image/x-icon"
        default:
            return "text/plain"
        }
    }
    
    private func sendFileResponse(connection: NWConnection, data: Data, mimeType: String) {
        let response = """
            HTTP/1.1 200 OK\r
            Content-Type: \(mimeType)\r
            Content-Length: \(data.count)\r
            Connection: close\r
            \r
            
            """
        
        var responseData = response.data(using: .utf8)!
        responseData.append(data)
        
        connection.send(content: responseData, completion: .contentProcessed { error in
            connection.cancel()
        })
    }
    
    private func sendResponse(connection: NWConnection, statusCode: Int, body: String) {
        let response = """
            HTTP/1.1 \(statusCode) \(getStatusText(statusCode))\r
            Content-Type: text/plain\r
            Content-Length: \(body.utf8.count)\r
            Connection: close\r
            \r
            \(body)
            """
        
        if let responseData = response.data(using: .utf8) {
            connection.send(content: responseData, completion: .contentProcessed { error in
                connection.cancel()
            })
        }
    }
    
    private func getStatusText(_ code: Int) -> String {
        switch code {
        case 200: return "OK"
        case 404: return "Not Found"
        case 405: return "Method Not Allowed"
        case 500: return "Internal Server Error"
        default: return "Unknown"
        }
    }
    #endif
    
    func stop() {
        listener?.cancel()
        printColored("🛑 HTTP Server stopped", color: .yellow)
    }
}

// Run swift run in Application directory
func runSwiftBuild() {
    printColored("🔄 Building...", color: .cyan, bold: true)
    
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
    process.arguments = ["run"]
    process.currentDirectoryURL = URL(fileURLWithPath: "Application")
    
    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        if process.terminationStatus == 0 {
            printColored("✅ Page reload complete", color: .green, bold: true)
        } else {
            printColored("❌ Build failed", color: .red, bold: true)
            if !output.isEmpty {
                printColored("Build errors:", color: .red)
                print(output)
            }
        }
    } catch {
        printColored("❌ Build failed: \(error)", color: .red, bold: true)
    }
}

// Clear terminal (works on macOS/Linux)
func clearTerminal() {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/clear")
    do {
        try process.run()
        process.waitUntilExit()
    } catch {
        printColored("⚠️  Failed to clear terminal: \(error)", color: .yellow)
    }
}

// Print header
func printHeader() {
    clearTerminal()
    printColored("🚀 Swift File Watcher + HTTP Server", color: .cyan, bold: true)
    printColored("Monitoring: Sources/**/*, ../Notes.playground/**/*", color: .blue)
    printColored("HTTP Server: http://localhost:8080 → Application/.output", color: .green)
    printColored("Polling interval: \(pollingInterval) seconds", color: .blue)
    printColored("Press Ctrl+C to stop", color: .blue)
    printColored("----------------------------------------", color: .blue)
}

// Start HTTP server
let httpServer = SimpleHTTPServer(port: 8080, documentRoot: "Application/.output")
httpServer.start()

// Collect initial file list and their modification dates
var fileDates: [String: Date] = [:]
for path in paths {
    for file in getFiles(in: path) {
        if let date = modificationDate(for: file) {
            fileDates[file] = date
        }
    }
}

printHeader()

// Run initial build
runSwiftBuild()
printColored("----------------------------------------", color: .blue)

// Main polling loop
while true {
    var changes: [(file: String, isNew: Bool)] = []
    
    // Check for changes or new files
    for path in paths {
        for file in getFiles(in: path) {
            if let newDate = modificationDate(for: file) {
                if let oldDate = fileDates[file] {
                    if newDate > oldDate {
                        changes.append((file: file, isNew: false))
                        fileDates[file] = newDate
                    }
                } else {
                    changes.append((file: file, isNew: true))
                    fileDates[file] = newDate
                }
            }
        }
    }
    
    // Handle deleted files
    fileDates.keys.forEach { file in
        if !fileManager.fileExists(atPath: file) {
            changes.append((file: file, isNew: false))
            fileDates.removeValue(forKey: file)
        }
    }
    
    // Process changes
    if !changes.isEmpty {
        printHeader()
        printColored("📝 Detected Changes at \(dateFormatter.string(from: Date()))", color: .yellow, bold: true)
        for change in changes {
            let action = change.isNew ? "New file" : "Modified/Deleted"
            printColored("  • \(action): \(change.file)", color: .green)
        }
        printColored("----------------------------------------", color: .blue)
        runSwiftBuild()
        printColored("----------------------------------------", color: .blue)
        printColored("🔍 Resuming monitoring...", color: .blue)
    }
    
    // Sleep to avoid excessive CPU usage
    Thread.sleep(forTimeInterval: pollingInterval)
}
