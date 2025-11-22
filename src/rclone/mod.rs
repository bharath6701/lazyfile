//! Rclone JSON-RPC API client and types.

pub mod client;
pub mod types;

pub use client::RcloneClient;
pub use types::*;
