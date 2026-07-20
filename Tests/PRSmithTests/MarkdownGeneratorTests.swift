import XCTest
@testable import PRSmith

final class MarkdownGeneratorTests: XCTestCase {
    let generator = MarkdownGenerator()

    func testEmptyChangesOmitsFileTableSection() {
        let markdown = generator.generate(for: [])
        XCTAssertTrue(markdown.contains("## Summary"))
        XCTAssertTrue(markdown.contains("No changes detected."))
        XCTAssertFalse(markdown.contains("## Changed Files"))
    }

    func testIncludesSummaryAndFileTableSections() {
        let files = [
            ChangedFile(status: .added, path: "New.swift"),
            ChangedFile(status: .modified, path: "Existing.swift"),
        ]
        let markdown = generator.generate(for: files)
        XCTAssertTrue(markdown.contains("## Summary"))
        XCTAssertTrue(markdown.contains("2 files changed"))
        XCTAssertTrue(markdown.contains("## Changed Files"))
        XCTAssertTrue(markdown.contains("| Added | New.swift |"))
    }
}
