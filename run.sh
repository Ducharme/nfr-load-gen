#!/bin/bash

# Exit on error
set -e

# Create results directory if not existing
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_DIR="./results/${TIMESTAMP}"
mkdir -p $RESULTS_DIR
chmod o+w $RESULTS_DIR

# Function to capture container stats
capture_stats() {
    local container_id=$1
    if docker ps -q -f "id=$container_id" >/dev/null 2>&1; then
        echo "Container resource usage to container_stats.json"
        docker stats $container_id --no-stream --format '{{json .}}' >> "$RESULTS_DIR/container_stats.json"
        echo "Detailed container info to container_info.json"
        docker stats $container_id --no-stream
        
        echo "Detailed container info to container_info.json"
        docker inspect $container_id >> "$RESULTS_DIR/container_info.json"
        docker inspect --format='Container Status: {{.State.Status}}, OOMKilled: {{.State.OOMKilled}}, ExitCode: {{.State.ExitCode}}, Error: {{.State.Error}}' $container_id
    else
        echo "Container not found - it may have already finished"
    fi
}

# Function to clean up
cleanup() {
    if [ ! -z "$CONTAINER_ID" ]; then
        echo "Capturing final stats..."
        capture_stats $CONTAINER_ID
    fi
    echo "Test completed. Results saved in $RESULTS_DIR"
    
    echo "Removing container..."
    docker rm -f $CONTAINER_ID || true
}

# Set up trap for cleanup
trap cleanup EXIT

# Run the container and capture its ID
echo "Running JMeter test..."
CONTAINER_ID=$(docker run -d --name jmeter-test -v $RESULTS_DIR:/jmeter/report jmeter-test)
# Wait for container to finish
docker wait $CONTAINER_ID
