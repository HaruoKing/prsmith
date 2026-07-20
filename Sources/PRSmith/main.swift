import ArgumentParser
import Foundation

struct PRSmith: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "prsmith",
        abstract: "Generate professional GitHub Pull Request descriptions from your Git changes.",
        version: "0.1.0"
    )

    @Option(name: [.short, .long], help: "Write the generated Markdown to a file instead of printing it.")
    var output: String?

    func run() throws {
        let markdown = try GenerationService().generate()

        guard let output else {
            print(markdown)
            return
        }

        let url = URL(fileURLWithPath: output)
        try markdown.write(to: url, atomically: true, encoding: .utf8)
        print("Wrote PR description to \(output)")
    }
}

PRSmith.main()
