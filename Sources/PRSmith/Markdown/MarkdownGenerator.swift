import Foundation

struct MarkdownGenerator {
    var summaryGenerator: SummaryGenerator
    var fileTableGenerator: FileTableGenerator

    init(
        summaryGenerator: SummaryGenerator = SummaryGenerator(),
        fileTableGenerator: FileTableGenerator = FileTableGenerator()
    ) {
        self.summaryGenerator = summaryGenerator
        self.fileTableGenerator = fileTableGenerator
    }

    func generate(for files: [ChangedFile]) -> String {
        var sections = [
            "## Summary",
            summaryGenerator.generate(for: files),
        ]

        let table = fileTableGenerator.generate(for: files)
        if !table.isEmpty {
            sections.append("## Changed Files")
            sections.append(table)
        }

        return sections.joined(separator: "\n\n")
    }
}
