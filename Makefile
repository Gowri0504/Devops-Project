# Makefile for Docker Networking Project

.PHONY: help up down test logs restart ps clean report

# Default target
help:
	@echo "Docker Networking Project Commands:"
	@echo "  make up      - Start the container stack (detached)"
	@echo "  make down    - Stop and remove the container stack"
	@echo "  make test    - Run the Python-based networking test suite"
	@echo "  make logs    - Show real-time container logs"
	@echo "  make restart - Restart all containers"
	@echo "  make ps      - List running containers"
	@echo "  make clean   - Remove all containers, networks, and volumes"
	@echo "  make report  - Display the last test report (JSON)"

up:
	docker-compose up -d

down:
	docker-compose down

test:
	python test_suite.py

logs:
	docker-compose logs -f

restart:
	docker-compose restart

ps:
	docker-compose ps

clean:
	docker-compose down -v --rmi all --remove-orphans

report:
	cat test_report.json
