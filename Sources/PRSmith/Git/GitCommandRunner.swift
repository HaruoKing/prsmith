import Foundation

enum GitCommandError: Error, CustomStringConvertible {
    case executionFailed(arguments: [String], exitCode: Int32, stderr: String)

    var description: String {
        switch self {
        case .executionFailed(let arguments, let exitCode, let stderr):
            let command = (["git"] + arguments).joined(separator: " ")
            return "Command failed (\(exitCode)): \(command)\n\(stderr)"
        }
    }
}

struct GitCommandRunner {
    var workingDirectory: URL

    init(workingDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)) {
        self.workingDirectory = workingDirectory
    }

    @discardableResult
    func run(_ arguments: [String]) throws -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["git"] + arguments
        process.currentDirectoryURL = workingDirectory

        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        process.standardOutput = stdoutPipe
        process.standardError = stderrPipe

        try process.run()
        process.waitUntilExit()

        let stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
        let stderrData = stderrPipe.fileHandleForReading.readDataToEndOfFile()
        let stdout = String(data: stdoutData, encoding: .utf8) ?? ""
        let stderr = String(data: stderrData, encoding: .utf8) ?? ""

        guard process.terminationStatus == 0 else {
            throw GitCommandError.executionFailed(
                arguments: arguments,
                exitCode: process.terminationStatus,
                stderr: stderr.trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }

        return stdout.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func diff(arguments: [String] = []) throws -> String {
        try run(["diff"] + arguments)
    }

    func status(arguments: [String] = ["--porcelain"]) throws -> String {
        try run(["status"] + arguments)
    }

    func currentBranch() throws -> String {
        try run(["branch", "--show-current"])
    }
}
