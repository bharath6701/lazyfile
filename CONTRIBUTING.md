# Contributing to LazyFile

Thank you for your interest in contributing to LazyFile. This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Submitting Changes](#submitting-changes)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Commit Messages](#commit-messages)

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally
3. Create a branch for your feature or fix
4. Make your changes
5. Test your changes thoroughly
6. Submit a pull request

### Prerequisites

- Rust 1.70 or later
- rclone configured with test remotes (for testing functionality)

## Development Setup

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/<your-username>/lazyfile.git
cd lazyfile
```

Build the project:

```bash
cargo build
```

Run the project:

```bash
# Terminal 1: Start rclone daemon WITHOUT authentication
rclone rcd --rc-addr localhost:5572 --rc-no-auth

# Terminal 2: Run LazyFile
cargo run
```

**Important:** Always use `--rc-no-auth` when running rclone RC for LazyFile development. LazyFile does not yet support authenticated RC servers.

Run tests:

```bash
cargo test
```

Run linting checks:

```bash
cargo clippy -- -D warnings
```

Format code:

```bash
cargo fmt
```

## Making Changes

### Branching Strategy

Create a feature branch for your work:

```bash
git checkout -b feature/descriptive-name
git checkout -b fix/issue-description
git checkout -b docs/documentation-improvement
```

Use a descriptive branch name that indicates what you're working on.

### Making Small Changes

For small bug fixes or documentation updates:

1. Make your changes
2. Run `cargo fmt` to format code
3. Run `cargo clippy -- -D warnings` to check for issues
4. Commit with a clear message
5. Submit your pull request

### Making Large Changes

For substantial features or architectural changes:

1. Open an issue first describing the proposed change
2. Wait for feedback from maintainers
3. Once approved, proceed with implementation
4. Keep commits atomic and logical
5. Write clear commit messages
6. Submit pull request with detailed description

## Submitting Changes

### Pull Request Process

1. Update the code with your changes
2. Ensure all tests pass: `cargo test`
3. Ensure code is formatted: `cargo fmt`
4. Ensure no clippy warnings: `cargo clippy -- -D warnings`
5. Write a clear pull request description
6. Submit the PR to the master branch
7. Respond to code review feedback

### Pull Request Description Template

```markdown
## Description

Brief description of what this PR does.

## Motivation and Context

Why is this change needed? What problem does it solve?

## Type of Change

- [ ] Bug fix (non-breaking change fixing an issue)
- [ ] New feature (non-breaking change adding functionality)
- [ ] Breaking change (change that would affect existing functionality)
- [ ] Documentation update

## Testing

How was this tested? What test cases cover the new functionality?

## Checklist

- [ ] My code follows the code style of this project
- [ ] I have updated the documentation accordingly
- [ ] I have tested my changes locally
- [ ] I have run clippy and addressed any warnings
- [ ] Commit messages are clear and descriptive
```

### What to Expect

- The maintainers will review your PR
- Feedback may be requested for changes or improvements
- Once approved, your PR will be merged
- You'll be credited as a contributor

## Coding Standards

LazyFile follows Rust conventions and best practices.

### Style Guide

- Use `cargo fmt` to format code automatically
- Follow [Rust naming conventions](https://rust-lang.org/api-guidelines/)
- Keep functions focused and single-purpose
- Use descriptive variable and function names
- Avoid abbreviations unless widely understood

### Code Quality

- Use clippy for linting: `cargo clippy -- -D warnings`
- Use types effectively: leverage Rust's type system to prevent errors
- Handle errors properly: use custom error types, not unwrap
- Document public APIs with rustdocs
- Write idiomatic Rust code

### Example: Documentation

All public items should have documentation:

````rust
/// Brief description of what this does.
///
/// Longer description if needed.
///
/// # Arguments
///
/// * `param1` - Description of param1
/// * `param2` - Description of param2
///
/// # Errors
///
/// Returns error if operation fails for specific reasons.
///
/// # Examples
///
/// ```
/// let result = my_function(value1, value2)?;
/// ```
pub fn my_function(param1: Type, param2: Type) -> Result<ReturnType> {
    // Implementation
}
````

### Error Handling

Use custom error types defined in `src/error.rs`:

```rust
use crate::error::{LazyFileError, Result};

pub async fn operation() -> Result<Output> {
    // Return errors using LazyFileError variants
    if something_wrong {
        return Err(LazyFileError::Config("message".to_string()));
    }

    // Use ? operator for automatic conversion
    let response = client.send().await?;

    Ok(result)
}
```

### Logging

Use tracing macros for structured logging:

```rust
use tracing::{debug, info, error, trace};

fn my_function() {
    debug!("Starting operation");

    match result {
        Ok(value) => info!("Operation succeeded"),
        Err(e) => error!("Operation failed: {}", e),
    }

    trace!("Detailed diagnostic information");
}
```

## Testing

### Running Tests

```bash
cargo test
```

Run tests with output:

```bash
cargo test -- --nocapture
```

Run a specific test:

```bash
cargo test test_name
```

### Writing Tests

Write tests for new functionality:

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_functionality() {
        let input = setup_test_data();
        let result = my_function(input);
        assert_eq!(result, expected_output);
    }
}
```

### Integration Tests

For integration tests, create files in the `tests/` directory at the project root.

### Testing with rclone

When testing changes that interact with rclone:

1. Ensure rclone daemon is running: `rclone rcd --rc-addr localhost:5572 --rc-no-auth`
2. Verify rclone has test remotes configured: `rclone config show`
3. Run the application: `cargo run`
4. Test the following operations:
   - Listing remotes in the left panel
   - Navigating into each remote and viewing files
   - Creating, editing, and deleting remotes (a, e, d keys)
   - Navigating through directory structures

5. Check logs for errors: `RUST_LOG=lazyfile=debug cargo run`

If the application shows "403 Forbidden", verify that rclone is running with `--rc-no-auth` flag.

## Documentation

### Rustdocs

All public APIs should have rustdocs:

```bash
cargo doc --open
```

This generates and opens HTML documentation for the project.

### Commit Message Documentation

Clear commit messages help others understand what changed and why:

```
Brief description (50 chars or less)

Longer explanation if needed. Explain the problem being solved
and why this solution was chosen.

Fixes #123
```

## Commit Messages

Write clear, descriptive commit messages:

### Format

```
<type>: <subject>

<body>

<footer>
```

### Types

- feat: A new feature
- fix: A bug fix
- docs: Documentation changes
- style: Code formatting (cargo fmt)
- refactor: Code refactoring without feature changes
- perf: Performance improvements
- test: Adding or updating tests
- chore: Build system, dependencies, tooling

### Examples

```
feat: add search functionality to file browser

Implement search within remotes to quickly find files.
Added search_files method to RcloneClient and integrated
with UI event handling.

Fixes #45
```

```
fix: handle rclone daemon connection errors

Improve error messages when rclone daemon is unreachable.
Return specific RcloneApi error instead of generic error.
```

```
docs: update README with logging examples

Add section explaining how to enable different log levels
for debugging issues with rclone communication.
```

## Areas for Contribution

### High Priority

- **Authentication support for rclone RC** (HTTP Basic Auth, Bearer tokens)
- File operations (copy, move, delete)
- Error handling and user-facing error messages
- Performance optimizations
- Bug fixes

### Medium Priority

- Configuration file support (for host/port/auth settings)
- Search and filter functionality within remotes
- Custom keybinding support
- Additional color themes
- Multi-file selection

### Implementation Notes

**Current Features Already Implemented:**

- Remote management (create, edit, delete remotes via `a`, `e`, `d` keys)
- Basic file browsing and navigation
- Two-panel interface

**Areas for Work:**
The `src/rclone/commands.rs` file contains placeholder constants for file operations that need implementation:

```rust
pub const MKDIR: &str = "operations/mkdir";
pub const DELETE_FILE: &str = "operations/deletefile";
pub const COPY_FILE: &str = "operations/copyfile";
pub const MOVE_FILE: &str = "operations/movefile";
```

These operations are not yet exposed in the UI or implemented in `RcloneClient`.

### Documentation

- README improvements
- API documentation
- Tutorial guides
- Troubleshooting guides
- Architecture documentation

### Low Priority

- Code refactoring (e.g., removing unnecessary `async` keywords)
- Test coverage improvements
- Build system enhancements

## Questions and Support

- Open an issue for bug reports
- Open a discussion for questions
- Check existing issues before reporting duplicates
- Include relevant information (OS, Rust version, error messages)

## Review Process

1. PR is submitted and automatically tested
2. Code review by maintainers
3. Feedback and discussion
4. Updates based on feedback
5. Final approval and merge

The process typically takes a few days to a week depending on the complexity of the change.

## Thank You

Your contributions make LazyFile better. Thank you for taking the time to contribute.
