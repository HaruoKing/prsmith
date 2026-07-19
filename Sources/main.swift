import ArgumentParser

struct PRSmith: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "prsmith",
        abstract: "Generate professional GitHub Pull Request descriptions from your Git changes."
    )
}

PRSmith.main()
