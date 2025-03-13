# ROS2 Docker Template

This repository provides a template for setting up a ROS 2 (Robot Operating System) development environment using Docker. It includes a Dockerfile and a Docker Compose configuration to build and run ROS 2 containers with ease.

## Project Structure

- `.env`: Contains environment variables for the Docker Compose file.
- `docker-compose.yaml`: Docker Compose configuration file to define and run multi-container Docker applications.
- `Dockerfile`: Dockerfile to build the ROS 2 base and development images.
- `entrypoint.sh`: Entrypoint script to source ROS 2 setup files.

## Getting Started

### Prerequisites

- Docker
- Docker Compose

### Setup

1. Clone the repository:
    ```sh
    git clone https://github.com/iamnambiar/ros2_docker_template.git
    cd ros2_docker_template
    ```

2. Build the Docker images:
    ```sh
    docker compose build
    ```

3. Run the Docker container:
    ```sh
    docker compose up -d [service_name]
    ```

4. Stop the container:
    ```sh
    docker compose down
    ```

### Usage

- The `base` service provides a base ROS 2 environment.
- The `dev` service extends the base environment with additional development tools and a user setup.

### Environment Variables

- `ROS_DISTRO`: Specifies the ROS 2 distribution (default: `humble`).
- `UID`, `GID`, `USERNAME`: User ID (default: `1000`), Group ID (default: `1000`), and Username (default: `user`) for the development container.

### Volumes

- `/tmp/.X11-unix`: Shared X11 socket for GUI applications.
- `./src:/colcon_ws/src`: Mounts the local `src` directory to the container's workspace.
