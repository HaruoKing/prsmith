import Foundation

struct ChangedFileParser {
    /// Parses the output of `git status --porcelain` into `ChangedFile` values.
    func parse(_ porcelainOutput: String) -> [ChangedFile] {
        porcelainOutput
            .split(separator: "\n", omittingEmptySubsequences: true)
            .compactMap { parseLine(String($0)) }
    }

    private func parseLine(_ line: String) -> ChangedFile? {
        guard line.count > 3 else { return nil }

        let code = line.prefix(2)
        let rest = String(line.dropFirst(3))

        if code.contains("R") {
            let parts = rest.components(separatedBy: " -> ")
            guard parts.count == 2 else {
                return ChangedFile(status: .renamed, path: rest)
            }
            return ChangedFile(status: .renamed, path: parts[1], originalPath: parts[0])
        }

        if code == "??" || code.contains("A") {
            return ChangedFile(status: .added, path: rest)
        }

        if code.contains("D") {
            return ChangedFile(status: .deleted, path: rest)
        }

        return ChangedFile(status: .modified, path: rest)
    }
}
