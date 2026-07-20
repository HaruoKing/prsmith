import Foundation

enum GitRepositoryError: Error, CustomStringConvertible {
    case notARepository(path: String)

    var description: String {
        switch self {
        case .notARepository(let path):
            return "\(path) is not inside a Git repository."
        }
    }
}

struct GitRepositoryDetector {
    var runner: GitCommandRunner

    init(runner: GitCommandRunner = GitCommandRunner()) {
        self.runner = runner
    }

    func isGitRepository() -> Bool {
        (try? runner.run(["rev-parse", "--is-inside-work-tree"])) == "true"
    }

    func requireGitRepository() throws {
        guard isGitRepository() else {
            throw GitRepositoryError.notARepository(path: runner.workingDirectory.path)
        }
    }
}
