# PRSmith

PRSmith is a cross-platform command-line tool, written in Swift, that generates professional GitHub Pull Request descriptions by analyzing your Git repository. It runs entirely offline and produces deterministic Markdown output.

## Installation

PRSmith is built with the Swift Package Manager. Clone the repository and build it from source:

```bash
git clone https://github.com/HaruoKing/prsmith.git
cd prsmith
swift build -c release
```

The built binary will be available at `.build/release/PRSmith`.

## Usage

Run the CLI from within a Git repository to print a generated PR description to the console:

```bash
swift run PRSmith
```

Write the description to a file instead of printing it:

```bash
swift run PRSmith --output PULL_REQUEST.md
```

Print the CLI version:

```bash
swift run PRSmith --version
```

See all available options:

```bash
swift run PRSmith --help
```

## Examples

```bash
$ swift run PRSmith --help
OVERVIEW: Generate professional GitHub Pull Request descriptions from your Git
changes.

USAGE: prsmith [--output <output>]

OPTIONS:
  -o, --output <output>   Write the generated Markdown to a file instead of
                          printing it.
  -h, --help              Show help information.
```

```bash
$ swift run PRSmith
## Summary

2 files changed: 1 added, 1 modified

## Changed Files

| Status | File |
| --- | --- |
| Added | Sources/PRSmith/NewFile.swift |
| Modified | Sources/PRSmith/main.swift |
```

## Roadmap

- [x] Initialize Swift package and CLI entry point
- [x] Parse changed files from Git
- [x] Generate Markdown PR descriptions
- [x] Output to console and file
- [ ] Branch comparison and clipboard support
- [ ] AI-assisted summaries

See the [GitHub Project board](https://github.com/users/HaruoKing/projects/1) and [milestones](https://github.com/HaruoKing/prsmith/milestones) for the full roadmap.

## License

MIT
