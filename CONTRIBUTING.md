# Contributing to PRSmith

Thanks for your interest in contributing! PRSmith is an open source Swift CLI, and contributions of all sizes are welcome.

## Getting Started

1. Fork the repository and clone your fork.
2. Build the project:
   ```bash
   swift build
   ```
3. Run the test suite:
   ```bash
   swift test
   ```
4. Run the CLI locally:
   ```bash
   swift run PRSmith --help
   ```

## Workflow

- All changes go through a pull request against `main` — direct pushes are disabled.
- Every pull request needs a passing CI run and an approving review before it can merge.
- Keep pull requests focused on a single issue where possible, and reference the issue number in the PR description (e.g. `Closes #12`).
- Use [Conventional Commits](https://www.conventionalcommits.org/) for commit messages (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `ci:`, `chore:`).

## Project Structure

```text
Sources/PRSmith/
├── main.swift
├── Commands/
├── Git/
├── Markdown/
├── Models/
├── Services/
└── Utilities/
```

See `Tests/` for the corresponding test suite.

## Reporting Issues

Please use [GitHub Issues](https://github.com/HaruoKing/prsmith/issues) and include:

- What you expected to happen
- What actually happened
- Steps to reproduce
- Your Swift and OS version

## Code Style

- Follow standard Swift API design guidelines.
- Prefer clear, descriptive names over abbreviations.
- Add tests for new behavior where practical.

## License

By contributing, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).
