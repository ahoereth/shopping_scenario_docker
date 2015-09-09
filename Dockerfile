FROM ros:indigo-ros-core
MAINTAINER Alexander Höreth "a.hoereth@gmail.com"

# Use bash.
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Required workaround for https://github.com/docker/docker/issues/1724 if
# using `apt-get upgrade` or `apt-get dist-upgrade`
#RUN dpkg-divert --local --rename /usr/bin/ischroot && ln -sf /bin/true /usr/bin/ischroot

# Initialize get and other tools.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq
RUN apt-get -y -f install python-software-properties \
                          software-properties-common \
                          build-essential \
                          apt-utils \
                          openssh-client \
                          git \
                          wget

# Install everything ROS and project related (bullet, prolog, gazebo)
RUN add-apt-repository -y ppa:swi-prolog/stable && \
    add-apt-repository "deb http://packages.osrfoundation.org/gazebo/ubuntu trusty main" && \
    wget http://packages.osrfoundation.org/gazebo.key -O gazebo.key && \
    apt-key add gazebo.key && apt-get update -qq
RUN apt-get -y -f install libjson-glib-dev \
                          libbullet-dev \
                          swi-prolog \
                          swi-prolog-java \
                          gazebo2
RUN apt-get -y -f install ros-indigo-rosjava \
                          ros-indigo-rosjava-messages \
                          ros-indigo-navigation \
                          ros-indigo-moveit-full-pr2 \
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
                          ros-indigo-pr2-mechanism-msgs \
                          ros-indigo-pr2-simulator \
                          ros-indigo-image-common \
                          ros-indigo-driver-common \
                          ros-indigo-gazebo-ros-pkgs \
                          ros-indigo-gazebo-ros-control \
                          ros-indigo-common-msgs

# Create User.
RUN useradd shopper -m
RUN echo "shopper:shopping" | chpasswd
ENV HOME /home/shopper
ENV WORKSPACE $HOME/catkin_ws
RUN mkdir -p $HOME $HOME/logs
RUN chown -R shopper:shopper /opt/ros/indigo/share

# Create raw workspace and get entrypoint script.
ADD scripts/entry.bash $HOME/entry.bash
ADD tmp/src $HOME/catkin_ws/src
RUN chown -R shopper:shopper $HOME

# Change to user.
USER shopper
RUN rosdep update

# Initialize workspace and build project WITHOUT shopping_scenario.
RUN source /opt/ros/indigo/setup.bash && \
    catkin_init_workspace $WORKSPACE/src && \
    catkin_make -C $WORKSPACE

# Add shopping_scenario and build again.
USER root
ADD tmp/shopping_scenario $WORKSPACE/src/shopping_scenario
RUN chown -R shopper:shopper $HOME
USER shopper
RUN source $WORKSPACE/devel/setup.bash && \
    catkin_make -C $WORKSPACE
RUN echo "source $WORKSPACE/devel/setup.bash" >> $HOME/.bashrc

# GUI
EXPOSE 11345
ENV QT_X11_NO_MITSHM 1

# Entrypoint and default command.
WORKDIR $WORKSPACE
ENTRYPOINT ["/home/shopper/entry.bash"]
CMD ["roslaunch", "shopping_scenario_executive", "start.launch"]
