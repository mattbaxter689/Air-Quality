#!/bin/bash

echo "Starting Kafka..."
/etc/confluent/docker/run &

TOPIC_NAME="weather-data"
BROKER="kafka:9092"

sleep 15

echo "Checking if topic '$TOPIC_NAME' exists..."
if kafka-topics --bootstrap-server "$BROKER" --list | grep -q "^$TOPIC_NAME$"; then
  echo "Topic '$TOPIC_NAME' already exists. Skipping creation."
else
  echo "Creating topic '$TOPIC_NAME'..."
  kafka-topics --bootstrap-server kafka:9092 \
        --create \
        --replication-factor 1 \
        --partitions 1 \
        --topic weather-data ;
      echo 'Topic created.' ;
  echo "Topic '$TOPIC_NAME' created."
fi