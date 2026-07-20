import XCTest
@testable import PRSmith

final class SummaryGeneratorTests: XCTestCase {
    let generator = SummaryGenerator()

    func testEmptyChangesReturnsNoChangesMessage() {
        XCTAssertEqual(generator.generate(for: []), "No changes detected.")
    }

    func testSingleFileUsesSingularWord() {
        let files = [ChangedFile(status: .added, path: "New.swift")]
        XCTAssertEqual(generator.generate(for: files), "1 file changed: 1 added")
    }

    func testMultipleFilesBreakdownByStatus() {
        let files = [
            ChangedFile(status: .added, path: "New.swift"),
            ChangedFile(status: .modified, path: "Existing.swift"),
            ChangedFile(status: .modified, path: "Other.swift"),
            ChangedFile(status: .deleted, path: "Gone.swift"),
        ]
        XCTAssertEqual(
            generator.generate(for: files),
            "4 files changed: 1 added, 2 modified, 1 deleted"
        )
    }
}
