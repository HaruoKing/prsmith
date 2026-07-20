import XCTest
@testable import PRSmith

final class ChangedFileTests: XCTestCase {
    func testEqualityIgnoresNothing() {
        let a = ChangedFile(status: .modified, path: "Sources/main.swift")
        let b = ChangedFile(status: .modified, path: "Sources/main.swift")
        XCTAssertEqual(a, b)
    }

    func testRenamedFileTracksOriginalPath() {
        let file = ChangedFile(status: .renamed, path: "New.swift", originalPath: "Old.swift")
        XCTAssertEqual(file.originalPath, "Old.swift")
    }

    func testDefaultOriginalPathIsNil() {
        let file = ChangedFile(status: .added, path: "New.swift")
        XCTAssertNil(file.originalPath)
    }
}
