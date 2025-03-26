# Contributing to Project Royale

We love your input! We want to make contributing to Project Royale as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## Development Process

We use GitHub to host code, to track issues and feature requests, as well as accept pull requests.

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Pull Request Process

1. Update the README.md with details of changes to the interface, if applicable.
2. Update the documentation with any new dependencies or removed ones.
3. The PR will be merged once you have the sign-off of two other developers.

## Code Style

### Unreal Engine

- Follow the [Unreal Engine Coding Standard](https://docs.unrealengine.com/5.0/en-US/epic-cplusplus-coding-standard-for-unreal-engine/)
- Use PascalCase for class names
- Use camelCase for variable names
- Prefix class names with appropriate letters (A for Actors, U for Objects)

### Smart Contracts

- Follow the [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)
- Use meaningful variable names
- Comment complex logic
- Include NatSpec documentation

### Documentation

- Use Markdown for all documentation
- Follow the [Google Developer Documentation Style Guide](https://developers.google.com/style)
- Keep documentation up to date with code changes

## Testing Requirements

### Game Testing

1. Unit Tests
   - All new features must include unit tests
   - Maintain 80% code coverage
   - Tests must pass on both Windows and macOS

2. Integration Tests
   - Test interaction between systems
   - Include multiplayer scenarios
   - Verify blockchain integration

3. Performance Tests
   - FPS benchmarks
   - Network latency tests
   - Memory usage tests

### Smart Contract Testing

1. Unit Tests
   - Test all contract functions
   - Include edge cases
   - Test access controls

2. Integration Tests
   - Test contract interactions
   - Verify token economics
   - Test upgrade procedures

## Reporting Bugs

We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/Blockchain1Royale/Project-Royale/issues/new); it's that easy!

### Write bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can.
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## License

By contributing, you agree that your contributions will be licensed under its MIT License. 