import Foundation

struct GenerationService {
    var repositoryDetector: GitRepositoryDetector
    var commandRunner: GitCommandRunner
    var changedFileParser: ChangedFileParser
    var markdownGenerator: MarkdownGenerator

    init(
        repositoryDetector: GitRepositoryDetector = GitRepositoryDetector(),
        commandRunner: GitCommandRunner = GitCommandRunner(),
        changedFileParser: ChangedFileParser = ChangedFileParser(),
        markdownGenerator: MarkdownGenerator = MarkdownGenerator()
    ) {
        self.repositoryDetector = repositoryDetector
        self.commandRunner = commandRunner
        self.changedFileParser = changedFileParser
        self.markdownGenerator = markdownGenerator
    }

    func generate() throws -> String {
        try repositoryDetector.requireGitRepository()
        let statusOutput = try commandRunner.status()
        let files = changedFileParser.parse(statusOutput)
        return markdownGenerator.generate(for: files)
    }
}
