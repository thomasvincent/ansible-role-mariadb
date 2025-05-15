.PHONY: lint test molecule-test molecule-test-all clean docs docker-test docker-replication-test

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

backup-test:
	cd molecule/backup && molecule test

monitoring-test:
	cd molecule/monitoring && molecule test

version-matrix-test:
	cd molecule/version-matrix && molecule test

molecule-test-all: 
	molecule test
	cd molecule/multi-instance && molecule test
	cd molecule/backup && molecule test
	cd molecule/monitoring && molecule test
	cd molecule/version-matrix && molecule test

docker-test:
	docker build -t mariadb-ansible-test .
	docker-compose up -d
	docker-compose exec -T mariadb mysql -u root -proot -e "SHOW DATABASES;"
	docker-compose exec -T mariadb mysql -u root -proot -e "SELECT VERSION();"
	docker-compose down

docker-replication-test:
	docker build -t mariadb-ansible-test .
	docker build -t mariadb-test -f tests/Dockerfile.test .
	docker-compose --profile test up -d mariadb-primary mariadb-replica
	sleep 30
	docker-compose --profile test run test-replication
	docker-compose --profile test down -v

docker-test-all: docker-test docker-replication-test

pre-commit:
	pre-commit run --all-files

docs:
	ansible-doc-extractor docs/generated roles/mariadb/tasks/*.yml

clean:
	rm -rf .molecule
	rm -rf .cache
	rm -rf __pycache__
	docker-compose down -v || true
	docker-compose --profile test down -v || true

all: lint molecule-test-all