import Foundation

struct FileTableGenerator {
    func generate(for files: [ChangedFile]) -> String {
        guard !files.isEmpty else {
            return ""
        }

        var lines = [
            "| Status | File |",
            "| --- | --- |",
        ]

        for file in files {
            let path: String
            if let originalPath = file.originalPath {
                path = "\(originalPath) → \(file.path)"
            } else {
                path = file.path
            }
            lines.append("| \(file.status.rawValue) | \(path) |")
        }

        return lines.joined(separator: "\n")
    }
}
