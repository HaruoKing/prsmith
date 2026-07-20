import Foundation

struct SummaryGenerator {
    func generate(for files: [ChangedFile]) -> String {
        guard !files.isEmpty else {
            return "No changes detected."
        }

        let counts = Dictionary(grouping: files, by: \.status).mapValues(\.count)
        let fileWord = files.count == 1 ? "file" : "files"
        var line = "\(files.count) \(fileWord) changed"

        let breakdown = FileChangeStatus.allCases
            .compactMap { status -> String? in
                guard let count = counts[status] else { return nil }
                return "\(count) \(status.rawValue.lowercased())"
            }

        if !breakdown.isEmpty {
            line += ": " + breakdown.joined(separator: ", ")
        }

        return line
    }
}
