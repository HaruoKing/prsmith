import Foundation

enum FileChangeStatus: String, Equatable, CaseIterable {
    case added = "Added"
    case modified = "Modified"
    case deleted = "Deleted"
    case renamed = "Renamed"
}

struct ChangedFile: Equatable {
    let status: FileChangeStatus
    let path: String
    let originalPath: String?

    init(status: FileChangeStatus, path: String, originalPath: String? = nil) {
        self.status = status
        self.path = path
        self.originalPath = originalPath
    }
}
