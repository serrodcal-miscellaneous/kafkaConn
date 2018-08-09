# Connector Kafka

Compile connector:

```bash
~$ mvn clean install
```

Copy the generated artifact into connector folder:

```bash
~$ cp target/kafkaPublisher-connector-1.0.0.zip connector
```

Start compose:

```bash
~$ docker-compose up
```

Enable connector in web admin console and create the API. Then,
send request to ESB resource:

```bash
~$ curl -i -X POST \
      -H "Content-Type:application/json" \
      -d \
   '{"example":"example"}' \
    'http://localhost:8280/kafka/publish/v1/send'
```

Finally, go into Kafka to check your message:

```bash
~$ docker exec -ti kafkaconn_kafka_1 bash
~$ /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
```

You should see `{"example":"example"}`.