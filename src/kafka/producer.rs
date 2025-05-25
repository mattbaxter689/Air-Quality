use rdkafka::config::ClientConfig;
use rdkafka::producer::{FutureProducer, FutureRecord};
use std::time::Duration;
use tokio::time::sleep;

use crate::model::HelloMessage;

pub async fn run_producer(broker: &str) {
    let producer: FutureProducer = ClientConfig::new()
        .set("bootstrap.servers", broker)
        .create()
        .expect("Error connecting to kafka client");

    loop {
        let msg = HelloMessage {
            message: "Hello World".to_string(),
        };

        let payload = serde_json::to_string(&msg).unwrap();

        let record = FutureRecord::to("weather-data")
            .payload(&payload)
            .key("key");

        match producer.send(record, Duration::from_secs(0)).await {
            Ok(delivery) => println!("[Producer] Delivered: {:?}", delivery),
            Err((e, _)) => eprintln!("[Producer] Error: {:?}", e),
        }

        sleep(Duration::from_secs(5)).await
    }
}
