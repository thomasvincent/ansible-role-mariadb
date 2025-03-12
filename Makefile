.PHONY: lint test molecule-test clean docs

lint:
	yamllint .
	ansible-lint

molecule-test:
	molecule test

molecule-converge:
	molecule converge

molecule-verify:
	molecule verify

multi-instance-test:
	cd molecule/multi-instance && molecule test

pre-commit:
	pre-commit run --all-files

docs:
	ansible-doc-extractor docs/generated roles/mariadb/tasks/*.yml

clean:
	rm -rf .molecule
	rm -rf .cache
	rm -rf __pycache__

all: lint molecule-test
