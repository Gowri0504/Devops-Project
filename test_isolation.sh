#!/bin/bash

# --- DevOps Project: Network Isolation Test Script ---
# Objective: Demonstrate that Frontend cannot talk to Database, but Backend can.

echo "--------------------------------------------------------"
echo "🚀 STARTING DOCKER NETWORK ISOLATION TESTS"
echo "--------------------------------------------------------"

# 1. Test Backend -> Database (Should SUCCEED)
echo "TEST 1: Backend to Database (Internal Network: db-network)"
docker exec track-placement-backend mongosh --host db --eval "db.adminCommand('ping')" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ SUCCESS: Backend reached Database."
else
    echo "❌ FAILED: Backend could not reach Database."
fi

echo ""

# 2. Test Frontend -> Backend (Should SUCCEED)
echo "TEST 2: Frontend to Backend (Internal Network: app-network)"
docker exec track-placement-frontend curl -s http://backend:3000/health > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ SUCCESS: Frontend reached Backend API."
else
    # Try the root if health is not found
    docker exec track-placement-frontend curl -s http://backend:3000/ > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ SUCCESS: Frontend reached Backend Root."
    else
        echo "❌ FAILED: Frontend could not reach Backend."
    fi
fi

echo ""

# 3. Test Frontend -> Database (Should FAIL - This proves isolation!)
echo "TEST 3: Frontend to Database (Isolation Check)"
echo "Checking if Frontend can reach Database on port 27017..."
# We use a timeout because if it's isolated, it will just hang/timeout
docker exec track-placement-frontend nc -zv -w 5 db 27017 > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "✅ SUCCESS: Isolation Verified! Frontend CANNOT reach Database."
else
    echo "❌ FAILED: Security Breach! Frontend reached Database."
fi

echo "--------------------------------------------------------"
echo "🎯 NETWORK TESTS COMPLETE"
echo "--------------------------------------------------------"
