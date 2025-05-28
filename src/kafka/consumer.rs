use crate::model::AirQualityHourly;
use rdkafka::config::ClientConfig;
use rdkafka::consumer::{Consumer, StreamConsumer};
use rdkafka::message::Message;
use tokio_stream::StreamExt;

pub async fn run_consumer(broker: &str) {
    let consumer: StreamConsumer = ClientConfig::new()
        .set("bootstrap.servers", broker)
        .set("group.id", "hello-group")
        .set("auto.offset.reset", "earliest")
        .create()
        .expect("Failed to create consumer");

    consumer
        .subscribe(&["weather-data"])
        .expect("Failed to subscribe to topic");

    println!("[Consumer] Listening for messages...");

    let mut message_stream = consumer.stream();

    while let Some(result) = message_stream.next().await {
        match result {
            Ok(msg) => {
                let payload_result = msg.payload_view::<str>();

                match payload_result {
                    Some(Ok(payload)) => match serde_json::from_str::<AirQualityHourly>(payload) {
                        Ok(parsed) => println!("[Consumer] Received: {}", parsed),
                        Err(e) => eprintln!("[Consumer] JSON error: {:?}", e),
                    },
                    None => eprintln!("[Consumer] No payload found"),
                    Some(Err(e)) => eprintln!("[Consumer] Payload decoding error: {:?}", e),
                }
            }
            Err(e) => eprintln!("[Consumer] Kafka error: {:?}", e),
        }
    }
}
