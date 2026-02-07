ARG ROS_DISTRO=jazzy

FROM osrf/ros:${ROS_DISTRO}-desktop AS base
LABEL version="1.0"
ENV ROS_DISTRO=${ROS_DISTRO}
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get -y upgrade && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /colcon_ws/src/thirdparty
WORKDIR /colcon_ws/src/thirdparty
COPY dependencies.repos .
RUN vcs import < dependencies.repos

WORKDIR /colcon_ws
RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
    && rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y \
    && colcon build --symlink-install

COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]

FROM base AS dev

ARG USERNAME=user
ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install -y --no-install-recommends gdb gdbserver vim \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --force --gid ${GID} ${USERNAME} \
    && useradd --non-unique --uid ${UID} --gid ${GID} --create-home --no-log-init ${USERNAME} \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && mkdir -p /home/${USERNAME} \
    && chown -R ${UID}:${GID} /home/${USERNAME}

RUN chown -R ${UID}:${GID} /colcon_ws/

USER ${USERNAME}
RUN echo "source /entrypoint.sh" >> /home/${USERNAME}/.bashrc