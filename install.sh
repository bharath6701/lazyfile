#!/bin/bash

# Installation script for LazyFile
# This script builds and installs LazyFile from source

set -e

VERSION="0.1.0"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}LazyFile Installation Script${NC}"
echo "Version: $VERSION"
echo ""

# Check if Rust is installed
if ! command -v cargo &> /dev/null; then
    echo -e "${RED}Error: Rust/Cargo is not installed${NC}"
    echo "Please install Rust from https://rustup.rs/"
    exit 1
fi

echo -e "${GREEN}✓${NC} Rust/Cargo found"

# Check if rclone is installed
if ! command -v rclone &> /dev/null; then
    echo -e "${YELLOW}⚠${NC} rclone is not installed"
    echo "Please install rclone from https://rclone.org/install/"
    echo "LazyFile requires rclone to function"
    exit 1
fi

echo -e "${GREEN}✓${NC} rclone found"

# Build the project
echo ""
echo -e "${YELLOW}Building LazyFile...${NC}"
cargo build --release

if [ ! -f "target/release/lazyfile" ]; then
    echo -e "${RED}Error: Build failed${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Build successful"

# Check if we need sudo
if [ ! -w "$INSTALL_DIR" ]; then
    echo ""
    echo -e "${YELLOW}Note: Installation directory requires sudo${NC}"
    INSTALL_CMD="sudo"
else
    INSTALL_CMD=""
fi

# Install binary
echo ""
echo -e "${YELLOW}Installing binary to $INSTALL_DIR...${NC}"
$INSTALL_CMD cp target/release/lazyfile "$INSTALL_DIR/lazyfile"
$INSTALL_CMD chmod +x "$INSTALL_DIR/lazyfile"

echo -e "${GREEN}✓${NC} LazyFile installed successfully!"
echo ""
echo -e "${GREEN}Installation Summary:${NC}"
echo "  Binary: $INSTALL_DIR/lazyfile"
echo "  Version: $VERSION"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Start the rclone RC daemon in a terminal:"
echo "   rclone rcd --rc-addr 127.0.0.1:5572 --rc-no-auth"
echo ""
echo "2. Run LazyFile:"
echo "   lazyfile"
echo ""
echo "For more information, see README.md and REMOTE_MANAGEMENT.md"
