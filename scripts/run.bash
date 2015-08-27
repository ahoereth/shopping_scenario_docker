#!/bin/bash
source ~/.bashrc
source /opt/ros/indigo/setup.bash
source ~/catkin_ws/devel/setup.bash
export PATH=$PATH:/opt/ros/indigo/bin
bash -c "$@"
