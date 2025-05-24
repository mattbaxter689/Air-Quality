mod kafka;

use clap::Parser;

#[derive(Parser, Debug)]
#[command(name = "Kafka CLI", version, about = "Run Kafka producer or consumer")]
struct Cli {
    #[arg(short, long, default_value = "localhost:9092")]
    broker: Option<String>,
}

fn main() {
    let cli = Cli::parse();

    if let Some(broker) = cli.broker.as_deref() {
        println!("Value for {broker}");
    }
}
