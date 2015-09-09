#!/bin/bash
set -e

source "/home/shopper/.bashrc"
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/home/shopper/catkin_ws/devel/setup.bash"
export ROS_LOG_DIR=~/logs/

exec "$@"
