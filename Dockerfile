FROM u2410_jre23_jmeter563:0.0.1

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set JMeter home
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV PATH=$JMETER_HOME/bin:$PATH

# Set working directory
WORKDIR /jmeter

# Create a non-root user (using different UID)
RUN groupadd -g 2020 jmeter && useradd -u 2020 -g jmeter -m -s /bin/bash jmeter

# Create directories &  Set proper permissions
RUN mkdir -p /jmeter/report
RUN chmod -R 777 /jmeter
RUN chown -R jmeter:jmeter /jmeter

# Switch to jmeter user
USER jmeter

# Copy JMeter test plan
COPY perf_test.jmx /jmeter/perf_test.jmx
# Create script to handle cleanup and test execution
COPY --chown=jmeter:jmeter run-test.sh /jmeter/run-test.sh
RUN chmod +x /jmeter/run-test.sh

ENTRYPOINT ["/jmeter/run-test.sh"]
