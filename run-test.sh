#!/bin/bash

# Exit on error
set -e

id
REPORT_DIR="/jmeter/report"

# Add debug flags
#export JVM_ARGS="-Djava.awt.headless=true -Dlog4j2.debug=true"

# Add property to suppress the warning
#echo "plugin_dependency_paths=../lib,../lib/ext" >> /opt/apache-jmeter-${JMETER_VERSION}/bin/user.properties

# Run JMeter test with specific log file location
jmeter -n -e -t perf_test.jmx \
  -l /jmeter/results.jtl \
  -o /jmeter/dashboard \
  -j /jmeter/jmeter.log \
  -Jjmeter.reportgenerator.overall_statistics_json=true \
  -Jsummariser.interval=1 \
  -Jsummariser.out=true \
  -Dlog4j2.formatMsgNoLookups=true \
  -Djmeter.log.level.root=DEBUG 2>&1 | tee console.log

JMETER_VERSION=5.6.3
cp -v /jmeter/results.jtl $REPORT_DIR/results.jtl
cp -v /jmeter/perf_test.jmx $REPORT_DIR/perf_test.jmx
cp -v /jmeter/console.log $REPORT_DIR/console.log
cp -v /jmeter/jmeter.log $REPORT_DIR/jmeter.log
echo "cp -r /jmeter/dashboard $REPORT_DIR/dashboard/"
cp -r /jmeter/dashboard $REPORT_DIR/dashboard/
cp -v /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter.properties $REPORT_DIR/jmeter.properties
cp -v /opt/apache-jmeter-${JMETER_VERSION}/bin/user.properties $REPORT_DIR/user.properties
