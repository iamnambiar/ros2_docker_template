ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}-ros-base

ARG ROS_DISTRO=jazzy
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV ROS_DISTRO=${ROS_DISTRO}

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-pip \
    python3-argcomplete \
    bash-completion \
    build-essential \
    git \
    vim \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update

RUN groupadd --gid ${USER_GID} ros \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m --shell /bin/bash ros \
    && echo "ros ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ros \
    && chmod 0440 /etc/sudoers.d/ros

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /ros2_ws
USER ros

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
