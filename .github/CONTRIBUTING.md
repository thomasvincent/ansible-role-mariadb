# Contributing Guidelines

Thank you for your interest in contributing to the MariaDB Ansible role!

## Code of Conduct

By participating in this project, you agree to abide by the [Ansible Community Code of Conduct](https://docs.ansible.com/ansible/latest/community/code_of_conduct.html).

## How to Contribute

### Reporting Issues

- Check if the issue has already been reported
- Use the issue templates when available
- Include detailed steps to reproduce the issue
- Specify your environment (Ansible version, OS, etc.)

### Submitting Changes

1. Fork the repository
2. Create a new branch from `main`
3. Make your changes following our coding standards
4. Add tests for your changes
5. Ensure all tests pass with `molecule test`
6. Submit a pull request

### Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) standard. Each commit message should have a structured format:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

Types include:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Example:
```
feat(replication): add support for MariaDB Galera Cluster

Adds functionality to configure Galera cluster parameters
and manage multi-node synchronous replication.

Resolves: #123
```

### Development Environment

1. Clone the repository
2. Install development dependencies:
   ```
   pip install molecule molecule-plugins[docker] docker pytest-testinfra
   ```
3. Run tests:
   ```
   molecule test
   ```

### Testing

- All new features should include appropriate tests
- All bug fixes should include tests that reproduce the issue
- Run all tests before submitting a pull request
- We use Molecule for testing - see molecule directory for examples

## Release Process

1. Releases are created by tagging the main branch
2. Version numbers follow semantic versioning (X.Y.Z)
3. Release notes should detail what changed in the release
4. GitHub Actions will automatically create a release when a tag is pushed

Thank you for contributing to make this role better!