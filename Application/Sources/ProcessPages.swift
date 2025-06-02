import Foundation

/// Returns the base directory of the script.
func getBaseDirectory() -> URL {
    let scriptPath = CommandLine.arguments[0]
    let scriptURL = URL(fileURLWithPath: scriptPath)
    return scriptURL.deletingLastPathComponent()
}

/// Lists all `.xcplaygroundpage` files in the given directory.
/// - Parameter directory: The directory to search.
/// - Returns: An array of URLs to playground pages.
func listPlaygroundPages(in directory: URL) -> [URL] {
    let fm = FileManager.default
    guard
        let enumerator = fm.enumerator(
            at: directory,
            includingPropertiesForKeys: nil
        )
    else { return [] }
    var pages: [URL] = []
    for case let fileURL as URL in enumerator {
        if fileURL.pathExtension == "xcplaygroundpage" {
            pages.append(fileURL)
        }
    }
    return pages.sorted { $0.path < $1.path }
}

/// Creates the output directory if it does not exist.
/// - Parameter url: The directory URL.
func makeOutputDirectory(_ url: URL) {
    try? FileManager.default.createDirectory(
        at: url,
        withIntermediateDirectories: true,
        attributes: nil
    )
}

/// Reads all lines from a file.
/// - Parameter url: The file URL.
/// - Returns: An array of lines as strings.
func readLines(from url: URL) -> [String] {
    guard let data = try? Data(contentsOf: url),
        let content = String(data: data, encoding: .utf8)
    else { return [] }
    return content.components(separatedBy: .newlines)
}

/// Writes a string to a file.
/// - Parameters:
///   - string: The string to write.
///   - url: The file URL.
func write(_ string: String, to url: URL) {
    try? string.write(to: url, atomically: true, encoding: .utf8)
}

/// Processes the contents of a Swift playground page and converts it to markdown.
/// - Parameter url: The file URL.
/// - Returns: The processed markdown string.
func processContentsSwift(at url: URL) -> String {
    let lines = readLines(from: url)
    var output = ""
    var inComment = false
    var inCode = false
    var buffer = ""

    func flushCodeBlock() {
        if !buffer.isEmpty {
            output +=
                buffer.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
            buffer = ""
        }
        if inCode {
            output += "```\n"
            inCode = false
        }
    }

    for line in lines {
        if line.hasPrefix("//: [") { continue }
        if line.contains("/*:") {
            flushCodeBlock()
            inComment = true
            continue
        }
        if line.contains("*/") && inComment {
            inComment = false
            continue
        }
        if inComment {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            output += trimmed + "\n"
            continue
        }
        if line.hasPrefix("///:") {
            flushCodeBlock()
            let markdown = line.replacingOccurrences(of: "///:", with: "")
                .trimmingCharacters(in: .whitespaces)
            output += markdown + "\n"
            continue
        }
        if line.trimmingCharacters(in: .whitespaces).isEmpty {
            if inCode {
                buffer += "\n"
            } else {
                output += "\n"
            }
            continue
        }
        if !inCode {
            output += "\n```swift\n"
            inCode = true
        }
        var codeLine = line
        if codeLine.hasPrefix(" ") {
            codeLine.removeFirst()
        }
        buffer += codeLine + "\n"
    }
    if inCode {
        output += buffer.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
        output += "```\n"
    }
    return output
}

/// Processes all playground pages and generates markdown articles.
/// - Parameters:
///   - playgroundPagesDir: The directory containing playground pages.
///   - outputDir: The directory to write markdown articles to.
func processPlaygroundPagesToArticles(
    from playgroundPagesDir: URL,
    to outputDir: URL
) {
    makeOutputDirectory(outputDir)
    let pages = listPlaygroundPages(in: playgroundPagesDir)

    var toc = """
        <details id="contents">
        <summary><strong>Table of Contents</strong></summary><ol>

        """

    for page in pages {
        let baseName = page.deletingPathExtension().lastPathComponent
        let strippedName: String
        if baseName.count > 3,
            baseName[baseName.index(baseName.startIndex, offsetBy: 2)] == "-"
        {
            strippedName = String(baseName.dropFirst(3))
        } else {
            strippedName = baseName
        }
        if baseName == "00-Introduction" {
            toc += "<li><a href=\"/\">\(strippedName)</a></li>\n"
        } else {
            let slugifiedName = strippedName.lowercased().replacingOccurrences(of: " ", with: "-")
            toc += "<li><a href=\"/\(slugifiedName)\">\(strippedName)</a></li>\n"
        }
    }
    toc += "\n</ol></details>\n\n---\n"

    for page in pages {
        let baseName = page.deletingPathExtension().lastPathComponent
        let strippedName: String
        if baseName.count > 3,
            baseName[baseName.index(baseName.startIndex, offsetBy: 2)] == "-"
        {
            strippedName = String(baseName.dropFirst(3))
        } else {
            strippedName = baseName
        }
        let contentFile = page.appendingPathComponent("Contents.swift")
        let outputFile: URL
        if baseName == "00-Introduction" {
            outputFile = outputDir.appendingPathComponent("index.md")
        } else {
            let slugifiedName = strippedName.lowercased().replacingOccurrences(of: " ", with: "-")
            outputFile = outputDir.appendingPathComponent("\(slugifiedName).md")
        }
        var fileContent = toc
        if FileManager.default.fileExists(atPath: contentFile.path) {
            fileContent += processContentsSwift(at: contentFile)
            write(fileContent, to: outputFile)
        }
    }
}
