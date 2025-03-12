# Contributing to Enterprise MariaDB Ansible Role

Thank you for your interest in contributing to this project! Here's how you can help.

## Code of Conduct

Please keep interactions respectful and professional.

## How Can I Contribute?

### Reporting Bugs

- Use the bug report template
- Include detailed steps to reproduce
- Specify your environment (OS, Ansible version, MariaDB version)

### Suggesting Features

- Use the feature request template
- Explain the use case for the feature
- Consider alternatives you've explored

### Pull Requests

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests to ensure they pass (`molecule test`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Process

### Testing

We use Molecule for testing. Before submitting a PR, make sure all tests pass:

```
molecule test
```

### Code Style

- Follow Ansible best practices
- Keep tasks idempotent
- Use YAML syntax consistently with 2-space indentation
- Document your code with comments where necessary

## Release Process

Releases are created by tagging commits:

1. Update version in metadata if needed
2. Create a tag (`git tag -a v1.0.0 -m "Release v1.0.0"`)
3. Push the tag (`git push origin v1.0.0`)
4. GitHub Actions will create a release automatically

## Questions?

If you have any questions, feel free to open an issue or contact the maintainers.
