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

Run the CLI from within a Git repository:

```bash
swift run PRSmith
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

USAGE: prsmith

OPTIONS:
  -h, --help              Show help information.
```

More usage examples will be added as PR generation features land.

## Roadmap

- [x] Initialize Swift package and CLI entry point
- [ ] Parse changed files from Git
- [ ] Generate Markdown PR descriptions
- [ ] Output to console and file
- [ ] Branch comparison and clipboard support
- [ ] AI-assisted summaries

See the [GitHub Project board](https://github.com/users/HaruoKing/projects/1) and [milestones](https://github.com/HaruoKing/prsmith/milestones) for the full roadmap.

## License

MIT
