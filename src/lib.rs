use serde::{Deserialize, Serialize};
#[derive(Serialize, Deserialize, Debug)]
pub struct HelloMessage {
    pub message: String,
}
