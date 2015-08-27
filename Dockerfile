FROM ros:indigo-ros-core
MAINTAINER Alexander Höreth "a.hoereth@gmail.com"

# Use bash.
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Initialize get and other tools.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y -f install python-software-properties \
                          software-properties-common \
                          build-essential \
                          apt-utils \
                          openssh-client \
                          git

# Install everything ROS and project related.
RUN add-apt-repository -y ppa:swi-prolog/stable && apt-get update
RUN apt-get -y -f install libjson-glib-dev \
                          libbullet-dev \
                          swi-prolog \
                          swi-prolog-java
RUN apt-get -y -f install ros-indigo-rosjava \
                          ros-indigo-rosjava-messages \
                          ros-indigo-navigation \
                          ros-indigo-moveit-full \
                          ros-indigo-robot-mechanism-controllers \
                          ros-indigo-ivcon ros-indigo-mjpeg-server \
                          ros-indigo-cram-3rdparty \
                          ros-indigo-convex-decomposition \
                          ros-indigo-realtime-tools \
                          ros-indigo-ros-control \
                          ros-indigo-roslisp \
                          ros-indigo-rosbridge-suite \
                          ros-indigo-pr2-common \
                          ros-indigo-pr2-controllers \
                          ros-indigo-pr2-mechanism \
                          ros-indigo-pr2-mechanism-msgs


# Create User.
RUN useradd shopper -m
RUN echo "shopper:shopping" | chpasswd
RUN mkdir -p /home/shopper
RUN chown -R shopper:shopper /opt/ros/indigo/share

# Create raw workspace.
ADD scripts/run.bash /home/shopper/run.bash
ADD tmp/src /home/shopper/catkin_ws/src
WORKDIR /home/shopper/catkin_ws
RUN chown -R shopper:shopper /home/shopper

# Change to user.
USER shopper

# Initialize workspace and build project WITHOUT shopping_scenario.
RUN source /opt/ros/indigo/setup.bash && \
    catkin_init_workspace src && \
    catkin_make

# Add shopping_scenario and build again.
USER root
ADD tmp/shopping_scenario ./src/shopping_scenario
RUN chown -R shopper:shopper /home/shopper
USER shopper
RUN source ./devel/setup.bash && \
    catkin_make

# Set image entrypoint and default command.
CMD ["roslaunch shopping_scenario_executive shopping_scenario.launch"]
ENTRYPOINT ["/home/shopper/run.bash"]
