import XCTest
@testable import PRSmith

final class GitRepositoryDetectorTests: XCTestCase {
    func testIsGitRepositoryTrueInsideRepo() {
        let detector = GitRepositoryDetector()
        XCTAssertTrue(detector.isGitRepository())
    }

    func testIsGitRepositoryFalseOutsideRepo() {
        let detector = GitRepositoryDetector(
            runner: GitCommandRunner(workingDirectory: FileManager.default.temporaryDirectory)
        )
        XCTAssertFalse(detector.isGitRepository())
    }

    func testRequireGitRepositoryThrowsOutsideRepo() {
        let detector = GitRepositoryDetector(
            runner: GitCommandRunner(workingDirectory: FileManager.default.temporaryDirectory)
        )
        XCTAssertThrowsError(try detector.requireGitRepository()) { error in
            XCTAssertTrue(error is GitRepositoryError)
        }
    }
}
