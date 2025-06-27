import Foundation
import Shared
import WebUI

@main
struct Application: Website {
    var metadata: Metadata {
        Metadata(from: PersonalData.metadata)
    }

    @WebsiteRouteBuilder
    var routes: [any Document] {
        get throws {
            // Fetch articles
            let articles = try ArticleService.fetchAllArticles(root: true)

            // Dynamic article routes
            for article in articles {
                article as any Document
            }
        }
    }

    var baseURL: String? {
        "https://notes.maclong.uk/comp-sci"
    }

    static func main() async throws {
        // Ensure Articles are generated from playground pages before building the site
        let baseDir = URL(
            fileURLWithPath: FileManager.default.currentDirectoryPath
        )
        let playgroundPagesDir = baseDir.appendingPathComponent(
            "../*.playground/"
        )
        let outputDir = baseDir.appendingPathComponent("Articles")
        processPlaygroundPagesToArticles(
            from: playgroundPagesDir,
            to: outputDir
        )

        do {
            let application = Application()
            try application.build()
            print("✓ Application built successfully.")
        } catch {
            print("⨉ Failed to build application: \(error)")
        }
    }
}
