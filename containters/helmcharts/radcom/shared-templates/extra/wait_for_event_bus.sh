#!/bin/bash
echo "Wating for event bus"
echo -n "Trying connect to http://eventbus-kafka-jmx-metrics:5556 .."
while ( ! curl http://eventbus-kafka-jmx-metrics:5556 > /dev/null 2>&1);do
	echo -n "."
	sleep 30
done
echo "."
echo "event bus is ready"
