import XCTest
@testable import PRSmith

final class FileTableGeneratorTests: XCTestCase {
    let generator = FileTableGenerator()

    func testEmptyChangesReturnsEmptyString() {
        XCTAssertEqual(generator.generate(for: []), "")
    }

    func testGeneratesTableHeader() {
        let table = generator.generate(for: [ChangedFile(status: .added, path: "New.swift")])
        XCTAssertTrue(table.hasPrefix("| Status | File |\n| --- | --- |"))
    }

    func testGeneratesRowPerFile() {
        let files = [
            ChangedFile(status: .added, path: "New.swift"),
            ChangedFile(status: .modified, path: "Existing.swift"),
        ]
        let table = generator.generate(for: files)
        XCTAssertTrue(table.contains("| Added | New.swift |"))
        XCTAssertTrue(table.contains("| Modified | Existing.swift |"))
    }

    func testRenamedFileShowsOldAndNewPath() {
        let files = [ChangedFile(status: .renamed, path: "New.swift", originalPath: "Old.swift")]
        let table = generator.generate(for: files)
        XCTAssertTrue(table.contains("| Renamed | Old.swift → New.swift |"))
    }
}
