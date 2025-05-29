#!/bin/bash

# Exit on any error
set -e

echo "Starting PokeMMO Kasm image tests..."

# Run the container
echo "Starting container..."
docker run -d --name pokemmo-test -p 6901:6901 pokemmo-test:latest

# Wait for container to start
echo "Waiting for container to initialize..."
sleep 30

# Check if container is running
echo "Checking container status..."
if ! docker ps | grep pokemmo-test > /dev/null; then
    echo "Container not running!"
    docker logs pokemmo-test
    exit 1
fi

# Check if Java process is running
echo "Checking Java process..."
if ! docker exec pokemmo-test ps aux | grep java > /dev/null; then
    echo "Java process not running!"
    docker logs pokemmo-test
    exit 1
fi

# Check if ROMs were downloaded
echo "Checking ROM downloads..."
if ! docker exec pokemmo-test ls /pokemmo/roms/pokemon_black.nds > /dev/null; then
    echo "Pokemon Black ROM not found!"
    exit 1
fi

if ! docker exec pokemmo-test ls /pokemmo/roms/pokemon_emerald.gba > /dev/null; then
    echo "Pokemon Emerald ROM not found!"
    exit 1
fi

# Check permissions
echo "Checking permissions..."
if ! docker exec pokemmo-test stat -c "%a" /pokemmo/roms/pokemon_black.nds | grep "644" > /dev/null; then
    echo "Incorrect ROM permissions!"
    exit 1
fi

# Check for errors in logs
echo "Checking logs for errors..."
if docker logs pokemmo-test 2>&1 | grep -i "error" > /dev/null; then
    echo "Found errors in logs!"
    docker logs pokemmo-test
    exit 1
fi

# Clean up
echo "Cleaning up..."
docker stop pokemmo-test
docker rm pokemmo-test

echo "All tests passed successfully!" 