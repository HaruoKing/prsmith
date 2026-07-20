import XCTest
@testable import PRSmith

final class GenerationServiceTests: XCTestCase {
    private func makeTempGitRepo() throws -> URL {
        let dir = FileManager.default.temporaryDirectory
            .appendingPathComponent("prsmith-tests-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let runner = GitCommandRunner(workingDirectory: dir)
        try runner.run(["init"])
        try runner.run(["config", "user.email", "test@example.com"])
        try runner.run(["config", "user.name", "Test"])
        return dir
    }

    func testGenerateThrowsOutsideGitRepository() {
        let dir = FileManager.default.temporaryDirectory
        let runner = GitCommandRunner(workingDirectory: dir)
        let service = GenerationService(
            repositoryDetector: GitRepositoryDetector(runner: runner),
            commandRunner: runner
        )
        XCTAssertThrowsError(try service.generate())
    }

    func testGenerateReturnsMarkdownForNewFile() throws {
        let dir = try makeTempGitRepo()
        defer { try? FileManager.default.removeItem(at: dir) }

        try "hello".write(to: dir.appendingPathComponent("New.swift"), atomically: true, encoding: .utf8)

        let runner = GitCommandRunner(workingDirectory: dir)
        let service = GenerationService(
            repositoryDetector: GitRepositoryDetector(runner: runner),
            commandRunner: runner
        )

        let markdown = try service.generate()
        XCTAssertTrue(markdown.contains("## Summary"))
        XCTAssertTrue(markdown.contains("1 file changed: 1 added"))
        XCTAssertTrue(markdown.contains("| Added | New.swift |"))
    }
}
