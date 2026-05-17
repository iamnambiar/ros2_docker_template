ARG ROS_DISTRO=rolling
FROM ros:${ROS_DISTRO}

ARG ROS_DISTRO
ENV ROS_DISTRO=${ROS_DISTRO}

RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep update

WORKDIR /ros2_ws

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
