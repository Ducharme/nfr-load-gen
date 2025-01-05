# JMeter Docker Performance Testing Framework

## Project Scope
This project provides a containerized Apache JMeter setup for executing performance tests. It includes:
- Automated test execution environment using Docker
- Sample test plan for archive.ubuntu.com
- Statistics collection and reporting
- Resource monitoring and logging
- Test results archival

## Requirements
- Ubuntu Server (tested on Ubuntu 24.10)
- Docker Engine
- Bash shell
- Internet connectivity for pulling base images and downloading JMeter

## Dependencies
- OpenJDK 23 JRE (installed automatically in container)
- Apache JMeter 5.6.3 (downloaded automatically during build)
- Docker Base Image: ubuntu:24.10
- User with Docker permissions

## Directory Structure

├── Dockerfile
├── Dockerfile-base
├── README.md
├── build.sh
├── build-base.sh
├── perf_test.jmx
├── run.sh
├── run-test.sh
└── results/
└── [timestamp]/
  ├── container_stats.json
  ├── container_info.json
  ├── results.jtl
  ├── console.log
  ├── jmeter.log
  ├── perf_test.jmx
  ├── jmeter.properties
  ├── user.properties
  └── dashboard/

## Installation Steps

1. Unzip the project nfr-perf.zip
2. Set execute permissions
```
chmod +x *.sh
```
3. Build the base image
```
bash ./build-base.sh
```
4. Build the test image
```
bash ./build.sh
```

# Usage

## Running Tests

Execute the test suite
```
bash ./run.sh
```

## Results Location

Test results are stored in ./results/[timestamp]/ directory, containing:
- JMeter dashboard report
- Test results (JTL format)
- Console output
- Container performance metrics
- JMeter logs and configuration files

## Force Rebuilding Base Image

To rebuild the base image (without changing the version)
```
bash ./build-base.sh --force
```

# Test Configuration

## JMeter Test Plan Structure (demo)

Setup Thread Group (Warm-up)
- 1 thread
- 5 iterations

Main Thread Group
- 1 thread
- 10 iterations
- 1 request per second (Constant Throughput Timer)


## Modifying Test Parameters

Edit perf_test.jmx to modify:
- Number of threads
- Test duration
- Request rate
- Target URLs
- Test scenarios

# Container Configuration

- Non-root user (UID: 2020)
- JMeter installed in /opt/apache-jmeter-5.6.3/
- Test files mounted in /jmeter/
- Results directory mounted from host

# Monitoring and Logging

- Container resource usage stats
- JMeter execution logs
- Test results and metrics
- Container health checks

# Troubleshooting

## Common Issues

1. Permission denied
```
sudo chown -R $USER:$USER .
chmod +x *.sh
```

2. Container name conflict
```
docker ps -a
docker rm -f jmeter-test
```

3. Port conflicts

Modify port mappings in Dockerfile if needed

## Logs Location

- JMeter logs: results/[timestamp]/jmeter.log
- Container logs: results/[timestamp]/container_info.json
- Console output: results/[timestamp]/console.log

# Security Considerations

- Runs as non-root user inside container
- No sensitive data stored in images
- Container cleanup after test completion
- Resource limits can be configured in run.sh
