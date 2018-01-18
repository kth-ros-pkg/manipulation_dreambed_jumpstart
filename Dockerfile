FROM osrf/ros:indigo-desktop-full
MAINTAINER Yoshua Nava (yoshua@kth.se)

# Add user 
RUN useradd -d /home/robdream -m -s /bin/bash robdream
RUN echo robdream:robdream | chpasswd
RUN usermod -aG sudo robdream
RUN echo 'robdream ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/robdream

# Update package lists
RUN apt-get update 

# Install basic development tools
RUN apt-get install -y \
	bash-completion \
	cmake \
	g++ \
	git \
    htop \
    ipython \
    nano \
    python-h5py \
    python-pip \
	python-software-properties \
	software-properties-common \ 
    qt4-dev-tools

# Install basic libraries not available in osrf image
RUN apt-get install -y \
	libegl1-mesa-dev \
	libgles2-mesa-dev \
	libsdl2-2.0-0

# Install libraries for building OpenRAVE
RUN add-apt-repository -y ppa:libccd-debs/ppa
RUN apt-get update 
# RUN pip install --upgrade ndg-httpsclient
RUN apt-get install -y \
	libassimp-dev \
	libavcodec-dev \
	libavformat-dev \
	libavformat-dev \
	libboost-all-dev \
	libboost-date-time-dev \
	libbullet-dev \
	libcairo2-dev \
	libccd-dev \
	libfaac-dev \
	libglew-dev \
	libgsm1-dev \
	libjasper-dev \
	liblapack-dev \
	libmpfr-dev \
	libode-dev \
	libogg-dev \
	libpcre3-dev \
	libpoppler-glib-dev \
	libqhull-dev \
	libqt4-dev \
	libsdl2-dev \
	libsoqt-dev-common \
	libsoqt4-dev \
	libspatialindex-dev \
	libswscale-dev \
	libswscale-dev \
	libtiff5-dev \
	libvorbis-dev \
	libx264-dev \
	libxml2-dev \
	libxrandr-dev \
	libxvidcore-dev \
	&& apt-get remove python-sympy

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install sympy==0.7.1       # Motivation: https://github.com/rdiankov/openrave/issues/369
RUN pip install matplotlib \ 
				numpy \
				numpy-stl \
				python-igraph \
				pyyaml \
				Rtree \                 
				scikit-learn \
				scipy \
				tf

# Install ROS dependencies
RUN apt-get install -y \
	ros-indigo-rosbash \
	ros-indigo-socketcan-interface \
	ros-indigo-libccd \
	ros-indigo-soem

# # Delete the apt cache to keep container size to a minimum
# RUN rm -rf /var/lib/apt/lists/*



# Change to user robdream context
USER robdream
ENV HOME /home/robdream

### OpenRAVE build process
WORKDIR /home/robdream
ARG DREAMBED_DEPENDS=/home/robdream/dreambed_depends
RUN mkdir -p $DREAMBED_DEPENDS
# COLLADA-DOM
WORKDIR $DREAMBED_DEPENDS
RUN git clone https://github.com/rdiankov/collada-dom.git
RUN mkdir -p $DREAMBED_DEPENDS/collada-dom/build
WORKDIR $DREAMBED_DEPENDS/collada-dom/build
RUN cmake ..
RUN make -j4
RUN sudo make install
# OpenSceneGraph
WORKDIR $DREAMBED_DEPENDS
RUN git clone https://github.com/openscenegraph/OpenSceneGraph.git
WORKDIR $DREAMBED_DEPENDS/OpenSceneGraph
RUN git checkout OpenSceneGraph-3.4
RUN mkdir -p $DREAMBED_DEPENDS/OpenSceneGraph/build
WORKDIR $DREAMBED_DEPENDS/OpenSceneGraph/build
RUN cmake .. -DDESIRED_QT_VERSION=4
RUN make -j4
RUN sudo make install
# Flexible Collision Library
WORKDIR $DREAMBED_DEPENDS
RUN git clone https://github.com/flexible-collision-library/fcl.git
WORKDIR $DREAMBED_DEPENDS/fcl
RUN git checkout 0.5.0  # use FCL 0.5.0
RUN mkdir -p $DREAMBED_DEPENDS/fcl/build
WORKDIR $DREAMBED_DEPENDS/fcl/build
RUN cmake ..
RUN make -j4
RUN sudo make install
# OpenRAVE
WORKDIR $DREAMBED_DEPENDS
RUN git clone https://github.com/rdiankov/openrave.git
WORKDIR $DREAMBED_DEPENDS/openrave
RUN git checkout latest_stable
RUN mkdir -p $DREAMBED_DEPENDS/openrave/build
WORKDIR $DREAMBED_DEPENDS/openrave/build
RUN cmake .. -DOSG_DIR=/usr/local/lib64/
RUN make -j4
RUN sudo make install
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$(openrave-config --python-dir)/openravepy/_openravepy_
ENV PYTHONPATH $PYTHONPATH:$(openrave-config --python-dir)



### Dreambed ROS workspace setup
# Creation
RUN mkdir -p /home/robdream/dreambed_ws/src
ENV DREAMBED_WS /home/robdream/dreambed_ws/
WORKDIR $DREAMBED_WS/src
RUN /bin/bash -c "source /opt/ros/indigo/setup.bash; catkin_init_workspace"
# Cloning of ROS packages
RUN git clone https://github.com/kth-ros-pkg/hfts_grasp_planner
RUN git clone https://github.com/kth-ros-pkg/manipulation_dreambed.git
RUN git clone https://github.com/kth-ros-pkg/kmr_dream_portfolio.git
## Question: Should we clone kmr_ros_sim too? Where should we get it from?
# Build workspace
WORKDIR $DREAMBED_WS/
RUN /bin/bash -c "source /opt/ros/indigo/setup.bash; catkin_make -DCMAKE_BUILD_TYPE=Release"
RUN /bin/bash -c "echo 'source /home/robdream/dreambed_ws/devel/setup.bash' >> /home/robdream/.bashrc"

WORKDIR $HOME