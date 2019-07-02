ARG PYVER=3.7
FROM pymor/python:$PYVER

MAINTAINER rene.milk@wwu.de

ARG DEALIIVERSION

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
#for add-apt-repo
RUN apt-get install -y software-properties-common \
    gfortran cmake \
    git \
    gsl-bin \
    libblas-dev \
    libbz2-dev \
    libgsl-dev \
    liblapack-dev \
    libnetcdf-c++4-dev \
    libnetcdf-cxx-legacy-dev \
    libnetcdf-dev \
    libarpack2-dev libsuitesparse-dev libboost-all-dev libgmsh-dev \
    liblapack-dev libmuparser-dev libmetis-dev libtbb-dev \
    ninja-build \
    numdiff \
    unzip \
    wget \
    zlib1g-dev \
    libopenmpi-dev \
# next line is necessary for xfvb/qt/gl demo to work, needed till imaged rebased on pymor/testing
    xauth x11-apps xvfb libgl1-mesa-dri libglu1-mesa \
    openmpi-bin gosu && \
    pip install numpy

RUN cd /tmp && git clone https://github.com/dealii/dealii.git dealii-${DEALIIVERSION}-src && \
    cd dealii-${DEALIIVERSION}-src && \
    git checkout v${DEALIIVERSION} && \
    mkdir build && cd build && \
    cmake -DDEAL_II_WITH_MPI=ON \
          -DDEAL_II_COMPONENT_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DCMAKE_BUILD_TYPE=Release \
          -DDEAL_II_ALLOW_BUNDLED=OFF \
          -GNinja \
          ../ && \
    ninja -j "$(nproc)"  && \
    ninja -j 1 install && \
    cd / && rm -rf /tmp/deal*

# THE END
ENV DEBIAN_FRONTEND teletype
