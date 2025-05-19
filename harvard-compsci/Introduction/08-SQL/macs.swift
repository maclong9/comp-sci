import Foundation

/// Represents a Mac model with its release year and model name.
struct MacModel: Codable {
    let year: String
    let model: String
    
    /// Defines the mapping between JSON keys and struct properties.
    /// This is particularly useful when the keys in the data don't match
    /// the property names we want to use in our struct.
    enum CodingKeys: String, CodingKey {
        case year = "0"  // Maps the first column (index 0) to the 'year' property
        case model = "1" // Maps the second column (index 1) to the 'model' property
    }
}

/// Reads a CSV file and returns an array of MacModel instances.
/// - Parameter file: The path to the CSV file.
/// - Returns: An array of MacModel instances representing the data in the CSV file.
func readCSV(from file: String) -> [MacModel] {
    // Attempt to read the contents of the file
    guard let contents = try? String(contentsOfFile: file, encoding: .utf8) else {
        print("Failed to read file")
        return []
    }
    
		// Initialise results variable
    var results: [MacModel] = []
    
    // Split the contents into rows
    let rows = contents.components(separatedBy: .newlines)
    
    // Iterate through each row
    for row in rows.dropFirst() {
        // Split the row into columns
        let columns = row.components(separatedBy: ",")
        
        // Check if we have at least two columns and the first column is not empty
        if columns.count >= 2, !columns[0].isEmpty {
            // Create a new MacModel instance and append it to our results
            let macModel = MacModel(year: columns[0], model: columns[1])
            results.append(macModel)
        }
    }
    
    return results
}

/// Read the CSV file and get an array of MacModel instances
let macModels = readCSV(from: "./macs.csv")

/// Structure to keep track of counts of Mac models
struct ModelCounts {
    var Macintosh: Int = 0
    var PowerBook: Int = 0
    var iMac: Int = 0
    var iBook: Int = 0
    var Mini: Int = 0
    var MacBook: Int = 0
    var Pro: Int = 0
    var Studio: Int = 0
    
    /// Converts the model counts to a dictionary
    ///
    /// - Returns: A dictionary with keys as model names and the values are their respective counts
    func toDictionary() -> [String: Int] {
        return [
            "Macintosh": Macintosh,
            "PowerBook": PowerBook,
            "iMac": iMac,
            "iBook": iBook,
            "Mini": Mini,
            "MacBook": MacBook,
            "Pro": Pro,
            "Studio": Studio
        ]
    }
}

/// Initialise ModelCounts
var modelCounts = ModelCounts()

// Iterate through the MacModel instances and print information about each model
for mac in macModels {
    switch mac.model {
        case let str where str.contains("Macintosh"):
            modelCounts.Macintosh += 1
        case let str where str.contains("PowerBook"):
            modelCounts.PowerBook += 1
        case let str where str.contains("iMac"):
            modelCounts.iMac += 1
        case let str where str.contains("iBook"):
            modelCounts.iBook += 1
        case let str where str.contains("Mini"):
            modelCounts.Mini += 1
        case let str where str.contains("MacBook"):
            modelCounts.MacBook += 1
        case let str where str.contains("Pro"):
            modelCounts.Pro += 1
        case let str where str.contains("Studio"):
            modelCounts.Studio += 1
        default:
            break  // No match found
    }
}

// Sort the models according to value
let sortedModels = modelCounts.toDictionary().sorted { $0.value > $1.value }

print("The most common model is \(sortedModels[0].key) with \(sortedModels[0].value) versions.")
print("The least common model is \(sortedModels[7].key) with \(sortedModels[7].value) versions.")
