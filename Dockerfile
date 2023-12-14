# syntax=docker/dockerfile:1
FROM ros:noetic-ros-base

SHELL ["/bin/bash","-c"]

# install required noetic packages and gazebo
RUN apt-get update && apt-get install -y git \
    ros-noetic-joy ros-noetic-teleop-twist-joy \
    ros-noetic-teleop-twist-keyboard ros-noetic-amcl \
    ros-noetic-map-server ros-noetic-move-base \
    ros-noetic-urdf ros-noetic-xacro \
    ros-noetic-rqt-image-view ros-noetic-gmapping \
    ros-noetic-navigation ros-noetic-joint-state-publisher \
    ros-noetic-robot-state-publisher ros-noetic-slam-gmapping \
    ros-noetic-dwa-local-planner ros-noetic-joint-state-publisher-gui \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-compressed-image-transport \
    python3-dev

WORKDIR /
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src
RUN source /opt/ros/noetic/setup.bash \
    && catkin_init_workspace

# clone required packages
RUN git clone --recursive https://github.com/rigbetellabs/tortoisebot.git
RUN git clone https://github.com/ptientho/tortoisebot_waypoints.git
RUN git clone https://github.com/ptientho/tortoisebot_waypoints_interface.git

WORKDIR /catkin_ws
RUN source /opt/ros/noetic/setup.bash \
    && catkin_make

# set DISPLAY variable
ENV DISPLAY=:1

RUN echo source /catkin_ws/devel/setup.bash >> ~/.bashrc

# launch Gazebo
CMD /bin/bash -c "source devel/setup.bash; roslaunch tortoisebot_gazebo tortoisebot_playground.launch"