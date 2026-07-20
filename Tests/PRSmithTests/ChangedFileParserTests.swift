import XCTest
@testable import PRSmith

final class ChangedFileParserTests: XCTestCase {
    let parser = ChangedFileParser()

    func testParsesAddedFile() {
        let files = parser.parse("A  NewFile.swift")
        XCTAssertEqual(files, [ChangedFile(status: .added, path: "NewFile.swift")])
    }

    func testParsesUntrackedFile() {
        let files = parser.parse("?? Untracked.swift")
        XCTAssertEqual(files, [ChangedFile(status: .added, path: "Untracked.swift")])
    }

    func testParsesModifiedFile() {
        let files = parser.parse(" M Existing.swift")
        XCTAssertEqual(files, [ChangedFile(status: .modified, path: "Existing.swift")])
    }

    func testParsesDeletedFile() {
        let files = parser.parse(" D Removed.swift")
        XCTAssertEqual(files, [ChangedFile(status: .deleted, path: "Removed.swift")])
    }

    func testParsesRenamedFile() {
        let files = parser.parse("R  Old.swift -> New.swift")
        XCTAssertEqual(files, [ChangedFile(status: .renamed, path: "New.swift", originalPath: "Old.swift")])
    }

    func testParsesMultipleLines() {
        let output = "A  Added.swift\n M Modified.swift\n D Deleted.swift"
        let files = parser.parse(output)
        XCTAssertEqual(files.count, 3)
    }

    func testIgnoresEmptyOutput() {
        XCTAssertEqual(parser.parse(""), [])
    }
}
