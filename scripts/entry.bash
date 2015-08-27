#!/bin/bash
source ~/.bashrc
source /opt/ros/indigo/setup.bash
source ~/catkin_ws/devel/setup.bash
mkdir -p ~/logs/
export ROS_LOG_DIR=~/logs/
export PATH=$PATH:/opt/ros/indigo/bin
bash -c "$@"
