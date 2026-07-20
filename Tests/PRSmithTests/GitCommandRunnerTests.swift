import XCTest
@testable import PRSmith

final class GitCommandRunnerTests: XCTestCase {
    func testRunReturnsTrimmedStdout() throws {
        let runner = GitCommandRunner()
        let output = try runner.run(["rev-parse", "--is-inside-work-tree"])
        XCTAssertEqual(output, "true")
    }

    func testRunThrowsOnFailure() {
        let runner = GitCommandRunner()
        XCTAssertThrowsError(try runner.run(["not-a-real-git-subcommand"])) { error in
            XCTAssertTrue(error is GitCommandError)
        }
    }

    func testCurrentBranchDoesNotThrow() throws {
        // CI checks out PRs in detached HEAD, so the branch name may be empty —
        // this only asserts the git invocation itself succeeds.
        let runner = GitCommandRunner()
        _ = try runner.currentBranch()
    }
}
