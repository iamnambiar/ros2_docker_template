#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

usage() {
    echo "Usage: $0 <command>"
    echo ""
    echo "Commands:"
    echo "  build       Build the Docker image"
    echo "  start       Start an interactive shell in the container"
    echo "  up          Build and start"
    echo ""
}

case "$1" in
    build)
        docker compose build
        ;;
    start)
        xhost +local:docker 2>/dev/null || true
        docker compose run --rm ros2
        ;;
    up)
        docker compose build
        xhost +local:docker 2>/dev/null || true
        docker compose run --rm ros2
        ;;
    help | -h | --help)
        usage
        ;;
    *)
        usage
        exit 1
        ;;
esac
