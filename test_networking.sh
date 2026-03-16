#!/bin/bash

# Script to verify Docker networking isolation

echo "=== 1. Starting services with Docker Compose ==="
docker-compose up -d

echo -e "\n=== 2. Testing Communication from Frontend ==="
echo "Frontend -> Backend (Should SUCCEED):"
docker exec frontend-service ping -c 2 backend-service

echo -e "\nFrontend -> DB (Should FAIL):"
# This will fail as they are on different networks
docker exec frontend-service ping -c 2 db-service 2>/dev/null || echo "FAILED (As Expected)"

echo -e "\n=== 3. Testing Communication from Backend ==="
echo "Backend -> Frontend (Should SUCCEED):"
docker exec backend-service ping -c 2 frontend-service

echo -e "\nBackend -> DB (Should SUCCEED):"
docker exec backend-service ping -c 2 db-service

echo -e "\n=== 4. Testing Communication from DB ==="
echo "DB -> Backend (Should SUCCEED):"
docker exec db-service ping -c 2 backend-service

echo -e "\nDB -> Frontend (Should FAIL):"
# This will fail as they are on different networks
docker exec db-service ping -c 2 frontend-service 2>/dev/null || echo "FAILED (As Expected)"

echo -e "\n=== Network Inspection ==="
echo "Frontend Network Details:"
docker network inspect devops_frontend_net | grep -A 20 "Containers"

echo -e "\nBackend Network Details:"
docker network inspect devops_backend_net | grep -A 20 "Containers"

echo -e "\n=== Cleanup ==="
docker-compose down
