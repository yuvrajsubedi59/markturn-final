# Linux C++ build environment
FROM ubuntu:20.04
LABEL edu.uakron.email="ys96@zips.uakron.edu"

ARG DEBIAN_FRONTEND=noninteractive

# Installed packages for C++ build
RUN apt-get update && apt-get install -y \
    # Compiler
    g++ \
    gcc \
    # Version control
    git \
    # Build
    make \
    ninja-build \
    # Utilities
    curl \
    # Dev libraries
    libcurl4-openssl-dev \
    libyaml-cpp-dev \
    libjsoncpp-dev \
    libxml2-dev \
    # Remove unneeded apt updates
    && rm -rf /var/lib/apt/lists/*

# Install cmake binary directly
ARG CMAKE_VERSION=3.18.4
ARG CMAKE_URL=https://cmake.org/files/v3.18/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz
RUN curl -L ${CMAKE_URL} | tar xvz --strip-components=1 -C /usr/local

# Install CLI11.hpp from URL
ARG CLI11_VERSION=1.9.1
ARG CLI11_URL=https://github.com/CLIUtils/CLI11/releases/download/v${CLI11_VERSION}/CLI11.hpp
ADD $CLI11_URL /usr/local/include/