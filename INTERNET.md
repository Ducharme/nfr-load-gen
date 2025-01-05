# Required Internet Domain Access

## For Docker Image Build
- docker.io (Docker Hub)
  - Purpose: Pull Ubuntu base image
  - URL: docker.io/library/ubuntu:24.10

## For JMeter Installation
- archive.apache.org
  - Purpose: Download Apache JMeter binary
  - URL: https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.3.tgz

## For Ubuntu Package Management
- archive.ubuntu.com
  - Purpose: Ubuntu package repository
  - URLs: 
    - archive.ubuntu.com/ubuntu
    - security.ubuntu.com/ubuntu
  - Packages:
    - openjdk-23-jre-headless
    - wget

## For Test Execution
- archive.ubuntu.com
  - Purpose: Target website for JMeter test plan
  - Protocol: HTTP
  - Path: /

## Note
- If running behind a corporate proxy, ensure these domains are whitelisted
- For air-gapped environments:
  1. Pre-download the Ubuntu base image
  2. Pre-download JMeter binary
  3. Configure local package repository mirror
  4. Modify test plan to target internal services
