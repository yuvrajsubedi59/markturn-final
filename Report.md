# Midterm Exam - DevOps Fall 2020

### Yuvraj Subedi
### ys96@zips.uakron.edu  
  
---
- [Midterm Exam - DevOps Fall 2020](#midterm-exam---devops-fall-2020)
- [Abstract](#abstract)
- [Coding](#coding)
  - [`Git`](#git)
  - [`GitHub`](#github)
  - [GitHub Alternatives:](#github-alternatives)
- [Debugging](#debugging)
  - [`Docker Compose`](#docker-compose)
  - [`Unix Shells`](#unix-shells)
- [Building](#building)
  - [`Cmake`](#cmake)
  - [`Make`](#make)
  - [Make alternative: `Ninja`](#make-alternative-ninja)
- [Testing](#testing)
  - [`Docker`](#docker)
  - [`Docker Compose`](#docker-compose-1)
  - [`Shell Aliases`](#shell-aliases)
  - [`Shell Functions`](#shell-functions)
  - [`CTest`](#ctest)
- [Installation](#installation)
  - [`Cpack`](#cpack)
  - [`cmake install`](#cmake-install)
  - [`Systemd`](#systemd)
  - [`Apt install`](#apt-install)
  - [`dnf install`](#dnf-install)
# Abstract
Development process requires many tools. Tools used for coding, debugging, building, testing, installation come from the beginning of the develepment process. Many tools were developed with the invention of the technology and computer science. And these tools are always changing and updating with the modern development requirements. Old tools like `bash` , `cmake` are still used extensively whereas some recent tools like `docker` are famous among developers already. Some tools are for specific purposes like `cpack` for installation (package generation) whereas some tools like `docker compose` can be used for multiple purposes. In this report, a brief explanations of the development tools are presented. 
   
---
# Coding
## `Git`
`git`, developed by Finnish-American software engineer [Linus Trevolds](https://en.wikipedia.org/wiki/Linus_Torvalds), is a fast, flexible, powerful, multiuser version control higly used in development environment. `git` allows the development team to keep track of every files in local and remote repositories. The benefits of `git` are that it handles local and remote repositories, tracks merged data, stages the changes, and helps in debugging.  
  
In the project `markturn`, git is used as a project version control for the development. The collaborators of the project had the flexibility of sharing, tracking, and committing changes to the files.
Some of the major features of git and their brief description is as follows:  
+ `git status`: This command shows the current status of the local repository. It helps the developer to track what files are changed, what files are committed, or what files need to be pushed.
    ``` bash
    $ git status
    ```
+ `git diff`: This command displays what is changed in the local repository file than the one in the remote repository. This feature is used widely to check what changes are made to the file.
  ``` bash
  $ git diff
  ```
+ `git add`: This command adds the files to the staging area before committing in the local repository. This command doesn't affect any changes to the remote repository.
  ``` bash
  $ # add all changed and untracked files
  $ git add .

  $ # add all cpp files
  $ git add *.cpp

  $ # add Report.md only
  $ git add Report.md
+ `git commit -m`: This command is used to commit the changes made to the files in the local repository. `-m` flag is for the commit messages which explains what changes are made in the current commit.
  ``` bash
  $ git commit -m "Add coding section to the report"
  ```
+ `git push`: This command pushes the committed changes to the remote repository. 
  ``` bash
  $ # push the commit to master branch in remote repository
  $ git push origin master
  ```
+ `git pull`: This command pulls the changes made in the remote repository to the local repository.   
  ``` bash
  $ # pull the changes made in the remote repository
  $ git pull
  ```
### Alternative to git: `SVN(Subversion)`: 
SVN is used for more top-down approach with only one central repository.  
## `GitHub`
`GitHub` , owned by Microsoft, is the online version control service for hosting git repositories. It is widely used all over the world to host personal, private, business, and classroom repositories. 
In the project markturn, `GitHub` is used to host the remote git repositories where the project files are stored.
## GitHub Alternatives: 
+ [Gitlab](https://about.gitlab.com/), an open-source software, is an alternative to GitHub which provides similar services to GitHub.
+ [BitBucket](https://bitbucket.org/product) is another alternative to the GitHub.  
  
---
# Debugging
`Debugging` is the essential part of development. No codes or implementations are perfect at first. They get better and working with continous debugging. 
## `Docker Compose`
[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications. It helps the developers to debug their source code by providing different service platforms at once. Developers can check if their program works on different platforms and see the errors in their code. Docker compose also lets developers to run multiple commands at once and store the development cache in container which reduces the runtime of the program while running it second time.  
  
In the project `markturn`, Docker compose is used to set up different containers with different setup to run the project. It is a very powerful tools to run the project in container even if the project doesn't run with the local environment setup. 
## `Unix Shells`
A [Unix Shell](https://en.wikipedia.org/wiki/Unix_shell#:~:text=A%20Unix%20shell%20is%20a,the%20system%20using%20shell%20scripts.) is a command-line interpreter or shell that provides a command line user interface for Unix-like operating systems. The shell is both an interactive command language and a scripting language, and is used by the operating system to control the execution of the system using shell scripts. Most of the development is done with the CLI (Command Line Interface) because these environment provide a lot of debugging tools. We can check what shell we are using by:  
  ``` bash
  $ echo $0
  ```
  ``` bash
  -bash
  ```
Other examples of unix shells are zsh, sh, and ksh. Unix shells provide features like aliases, shell functions, and shell scripts which help in debugging. Shell functions are preferred over aliases because they allow parameters and do not use up a set up quotes. Shell functions are temporary unless they are written to ~/.{shell}/rc files.  
  
In the project `markturn`, aliases and shell functions are written to run the long commands with one word commands. For example:
  ``` bash
$ # set alias mountdocker to mount local directory to working container
$ alias mountdocker="docker run --workdir /build --mount type=bind,source="$(pwd)",target=/markturn,readonly -it markturn-fedora34"
  
$ #run the command
$ mountdocker
  ```  
[`Shell Functions`](#shell-functions) can be declared via the command line, or in a .bashrc file.  

---
# Building
The program is not done only by coding and debugging, it requires building. If the program doesn't build, there is no meaning of coding. There are many build tools like [CMake](https://cmake.org/), [SBT](https://www.scala-sbt.org/), and [Terraform](https://www.terraform.io/). The build tools used in the project `markturn` are described below:  
## `Cmake`  
Cmake uses the file `CMakeLists.txt` to build, generate, and deploy source code. It generates Makefile or other build files depending upon the generator used. [CMake](https://cmake.org/overview/) can generate a native build environment that will compile source code, create libraries, generate wrappers and build executables in arbitrary combinations.  
  
It is a good practice to store generated build files in different `build` directory so that the files won't mess up with the source code. Build directories are created aligning with source (sibling directories) directory or inside the source directory.
  
The `CMakeLists.txt` file created for the markturn project is as follow:
``` cmake
# Build for markturn

cmake_minimum_required(VERSION 3.18.4)

project(markturn)

option (LINK_STATIC "Build with static library" OFF)

# Find LibXml2
find_package(LibXml2 REQUIRED)
message("-- libxml2 include: " ${LIBXML2_INCLUDE_DIR})
message("-- libxml2 library: " ${LIBXML2_LIBRARY})

# Find CURL
find_package(CURL REQUIRED)
message("-- curl include: " ${CURL_INCLUDE_DIR})
message("-- curl library: " ${CURL_LIBRARY})

# Find YAML
set(YAML_CPP_DIR /usr/include/yaml-cpp)
message("-- YAML include: " ${YAML_CPP_DIR})

# Find JSON
set(JSON_CPP_DIR /usr/include/jsoncpp)
message("-- JSON include: " ${JSON_CPP_DIR})

# Set library include directories
set(LIBRARY_INCLUDE_DIRS ${LIBXML2_INCLUDE_DIR} ${YAML_CPP_DIR} ${JSON_CPP_DIR})

# Build and install markturn
set(EXECUTE_MARKTURN "src/markturn.cpp")
add_executable(markturn ${EXECUTE_MARKTURN})
if(LINK_STATIC)
    message("-- Static Library Used")
    target_link_libraries(markturn PUBLIC markturn_static)
else()
    message("-- Shared Library Used")
    target_link_libraries(markturn PUBLIC markturn_shared)
endif()
target_link_libraries(markturn PUBLIC ${CURL_LIBRARY})
install(TARGETS markturn RUNTIME)

# Glob source files for libraries
file(GLOB LIBRARY_SOURCES "src/*Format.cpp" "src/libmarkturn.cpp")

# Object markturn library
add_library(markturn_obj OBJECT ${LIBRARY_SOURCES})
target_include_directories(markturn_obj PUBLIC ${LIBRARY_INCLUDE_DIRS})

# Static markturn library
message("-- static library libmarktun.a")
add_library(markturn_static STATIC $<TARGET_OBJECTS:markturn_obj>)
target_link_libraries(markturn_static PUBLIC ${LIBXML2_LIBRARY})
set_target_properties(markturn_static PROPERTIES OUTPUT_NAME markturn)
install(TARGETS markturn_static LIBRARY)

# Shared markturn library
message("-- static library libmarktun.so")
add_library(markturn_shared SHARED $<TARGET_OBJECTS:markturn_obj>)
target_link_libraries(markturn_shared PUBLIC ${LIBXML2_LIBRARY})
set_target_properties(markturn_shared PROPERTIES OUTPUT_NAME markturn)
install(TARGETS markturn_shared LIBRARY)

# Run // -h ouput help command 
add_custom_target(run DEPENDS markturn COMMAND ./markturn -h)

# Markturn test program
enable_testing()

# All .cpp files in test/ are independent test programs
file(GLOB TEST_SOURCES "test/*.cpp")
foreach(TESTFILE ${TEST_SOURCES})
    get_filename_component(TEST_NAME ${TESTFILE} NAME_WLE)

    add_executable(${TEST_NAME} ${TESTFILE})
    target_include_directories(${TEST_NAME} PUBLIC ${LIBXML2_INCLUDE_DIR})
    target_include_directories(${TEST_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/src)
    target_link_libraries(${TEST_NAME} PUBLIC ${LIBXML2_LIBRARY})
    add_test(NAME ${TEST_NAME} COMMAND ${TEST_NAME})

    message("-- Added Test ${TEST_NAME} command ${TEST_NAME} program ${TESTFILE}")
    endforeach()

# Generate simple packages
set(CPACK_PACKAGE_NAME "markturn")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_VERSION_CONTACT "ys96@zips.uakron.edu")
include(CPack)

```  
The Cmake file generates required build files, sets the testing on, genrates installation packagages, genrates libraries builds, and finds the required packages.  
  
The required commands to execute the cmake file (assuming the build directory is inside the source directory) are:
``` bash
$ # generate build files by default generator
$ cmake ..

$ # generate build files using Ninja generator
$ cmake .. -G Ninja
```

## `Make`
Make is a build tool that uses a `Makefile` to compile and run the program. Makefile can be written by the developers themselves or use CMake tool to generate Makefile. Usually, Makefile can be written for simple projects and CMake is used to generate Makefile for complex projects. Following commands are executed to build and run the project with Makefile:
``` bash
$ # generate Makefile using CMake
$ cmake ..

$ # build the program
$ make

$ # run the program
$ make run

$ # test the program
$ make test

$ # clean the executable files *.o, *.obj
$ make clean

$ # install the program
$ make install
```
## Make alternative: `Ninja`
Ninja is a new tool that is used to build and run the program. It is an alternative to the Make tool. Usually, Ninja is slightly faster than Make. Ninja is used in the markturn project to run and build the program. The commands to use Ninja as a build tool are as follows:
``` bash
$ # generate Ninja build files
$ # -G flag tells cmake to use Ninja generator
$ cmake .. -G Ninja

$ # Build the program
$ ninja

$ # Run the program
$ ninja run

$ # test the program
$ ninja test

$ # clean the executable files *.o, *.obj
$ ninja clean

$ # install the program
$ ninja install
```
---
# Testing
## `Docker`
[Docker](https://www.docker.com/) is a very useful tool in building and testing the program. It allows to create a different environment required to run the program. Docker images are used or created to create the docker containers which provides a environment for the program to run and test. If my OS is Ubuntu 20.04 LTS and I want to develop my program so that I can run on multiple platforms like Ubuntu 20.10, Fedora 32, Fedora 34. In this case, I can create containers with the Ubuntu 20.10 environment, Fedora 32 environment, and Fedora 34 environment by creating a docker image for each of the platforms. 
  
This helps developers to test their programs in multiple platforms and environments and make sure the program works on every platforms. Docker containers are can be pulled off from [DockerHub](https://hub.docker.com/) or can be created by creating a [Dockerfile](https://docs.docker.com/engine/reference/builder/).  
  
In the project `markturn`, Dockerfile was created to provide required environments to the project and test the program in the container. The sample Dockerfile created for the project markturn for the environment Ubuntu 20.10 is as below:
``` Dockerfile
# Ubuntu 20.10 build environment for markturn project
FROM ubuntu:20.10
LABEL edu.uakron.email="ys96@zips.uakron.edu"

ARG DEBIAN_FRONTEND=noninteractive

# Installed packages for build
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
```
This Dockerfile builds an image that has required packages installed like g++, git, make, ninja-build, curl, and libraries. This image also has cmake 3.18.4, and CLI11 1.9.1 installed. These are the required features needed for the project markturn to run on the environment Ubuntu 20.10 which is set up in this Dockerfile. After building the image, container is run from this image where project is run and tested. 
  
To run and test the project in this built environment, following commands are executed:
``` bash
$ # Build an image 
$ docker build . -t markturn

$ # View os-release of the environment set up
$ docker run -it markturn cat /etc/os-release

$ # Run the container interactively
$ docker run -it markturn /bin/bash

$ # Share the local directory with docker container and run interactively
$ docker run --workdir /build --mount type=bind,source="$(pwd)",target=/markturn,readonly -it markturn
```

## `Docker Compose`
[Docker Compose](https://docs.docker.com/compose/) is a tool which can be used to run and automate testing for different services (platforms) at once. It reduces the runtime and processes to run and test the programs. It uses a file called `docker-compose.yml` to run the services and commands stored in the file. 
The project markturn used the following docker-compose.yml file to run and test the programs in different platforms:
``` Docker compose
# Docker compose version
version: "3.8"

# service name
services: ubuntu2004
    # image to use
    # ubuntu 20.04 LTS environment
    image: markturn-ubuntu2004

    # docker volumes
    volumes: 
      - type: bind
        source: "$(pwd)"
        target: /markturn
    working_dir: /build

    # commands to run
    command: "cmake ../markturn -G Ninja;
        ninja;
        ninja run;
        ninja test;
        ninja install;
        ninja clean;"

# service name
services: ubuntu2010
    # image to use
    # ubuntu 20.10 environment
    image: markturn-ubuntu2010

    # docker volumes
    volumes: 
      - type: bind
        source: "$(pwd)"
        target: /markturn
    working_dir: /build

    # commands to run
    command: "cmake ../markturn -G Ninja;
        ninja;
        ninja run;
        ninja test;
        ninja install;
        ninja clean;"
``` 
After the docker-compose.yml file is created, it can be executed with the following commands:
``` bash
$ # config is used to see any errors in docker-compose.yml file
$ docker-compose config

$ # up is used to run all the services at once
$ docker-compose up

$ # run ubuntu2010 service only
$ docker-compose ubuntu2010
```
This helps to run and test the program in all platforms at once.
## `Shell Aliases`
Shell aliases provide the short-form version of the command(s). It helps in testing by renaming long commands or multiple to a short form. These alias are stored in the current session only unless they are written to `~/.bashrc`  or  `~/.bash_profile` file. To perform the testing of markturn project, we can create one alias as follows:
``` bash
$ # create alias for all the commands to test markturn project
$ alias runmarkturn="cmake .. -G Ninja; ninja; ninja test; ninja clean"

$ # test the project in one command
$ testmarkturn

$ # view all the aliases
$ alias

$ # remove the alias
$ unalias runmarkturn
```
However, the drawbacks of the aliases are that it doesn't have parameters (only start of command) and uses up single quotes. These drawbacks can be ommitted by using shell functions which are described in the next section.
## `Shell Functions`
Shell functions are written in shell script which are used to automate the commands. To test the markturn project in docker container, following shell function is created:
``` bash
$ # shell function to test the markturn project in container
$ function testmarkturn(){
    # run the docker container
    docker run --workdir /build --mount type=bind,source="$(pwd)",target=/markturn,readonly -it markturn2004;

    # build the program
    cmake ../ -G Ninja;

    # run the program
    ninja;

    # test the program
    ninja test;
}

$ # perform the test
$ testmarkturn
```
## `CTest`
CMake has a testing tool called [ctest](https://cmake.org/cmake/help/latest/manual/ctest.1.html). It uses a test files created by developers. Testing with ctest is enabled in CMakeLists.txt file which also allows developers to glob all the test files and create the required program for all the test files. To enable the testing and create test program for the markturn project, following script is added to the CMakeLists.txt file: 

``` cmake
# markturn test program
enable_testing()

# all .cpp files in test/ are independent test programs
file(GLOB TEST_SOURCES "test/*.cpp")

# test for each testfiles
foreach(TESTFILE ${TEST_SOURCES})
    get_filename_component(TEST_NAME ${TESTFILE} NAME_WLE)

    add_executable(${TEST_NAME} ${TESTFILE})
    target_include_directories(${TEST_NAME} PUBLIC ${LIBXML2_INCLUDE_DIR})
    target_include_directories(${TEST_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/src)
    target_link_libraries(${TEST_NAME} PUBLIC ${LIBXML2_LIBRARY})
    add_test(NAME ${TEST_NAME} COMMAND ${TEST_NAME})

    message("-- Added Test ${TEST_NAME} command ${TEST_NAME} program ${TESTFILE}")
endforeach()
``` 
To perform the testing with the cmake, following commands are used:
``` bash
$ # generate test program
$ cmake .. -G Ninja
 
$ # perform testing
$ ninja test
```
---
# Installation
It is not a good practice to build, test, and run the program from source code everytime. The program needs to be installed in the OS to be able to use it without source code. 
## `Cpack`
[Cpack](https://cmake.org/cmake/help/latest/module/CPack.html) is a tool used by CMake to generate required installation packages. In the project markturn, cpack is used to generate simple installation packages like tgz, zip. In the CMakeLists.txt, the following lines are added to set the package details and generate simple packages using cpack:
``` cmake
# Generate simple packages
set(CPACK_PACKAGE_NAME "markturn")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_VERSION_CONTACT "ys96@zips.uakron.edu")
include(CPack)
```
  
The command used to generate installation packages with cpack is: 
``` bash
$ # build the program
$ cmake .. -G Ninja

$ # run the program
$ ninja

$ # generate simple packages
$ cpack

$ # generate packages for Debian based environments
$ cpack -G DEB
```
## `cmake install`
CMake uses a tool called "[install](https://cmake.org/cmake/help/v3.13/command/install.html)" to install the program, packages, and libraries. In the project markturn, the markturn program, and libraries are installed using cmake install. After building the markturn program and it's libraries, following lines are added to CMakeLists.txt to install the program in the working environment. 
``` cmake
# install markturn program (executable)
install(TARGETS markturn RUNTIME)

# install built static library
install(TARGETS markturn_static LIBRARY)

# install built shared library
install(TARGETS markturn_shared LIBRARY)
```  

After adding the install lines to CMakeLists.txt, following commands are run to install the program and libraries:
``` bash
$ # build and run the program
$ cmake .. -G Ninja; ninja;

$ # install the program
$ ninja install
```
## `Systemd`
[Systemd](https://en.wikipedia.org/wiki/Systemd) is a program that allows user to set their program as a service. This tools starts the installed program and run when the OS starts. For the project markturn, markturn.service file is created in the /etc/systemd/system directory. 
``` ini
[Unit]
Description=markturn service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/markturn

[Install]
WantedBy=multi-user.target
```
After creating the markturn.service file, following commands are executed to start and stop the service:
``` bash
$ # start the service
$ systemctl start markturn

$ # stop the service
$ systemctl stop markturn
```
To start the service everytime when the system restarts, the following commands are executed to enable and disable the service:
``` bash
$ # enable the service
$ systemctl enable markturn

$ # disable the service
$ systemctl disable markturn
```
## `Apt install`
[Debian based systems](https://www.debian.org/intro/about) like ubuntu uses `apt` as their package manager. Command `apt install` is used to install packages in the debian based systems. To install a [git](https://git-scm.com/), following command can be run:
``` bash
$ # Install git on Ubuntu
$ apt install git
```
## `dnf install`
[RPM-based linux distributions](https://en.wikipedia.org/wiki/Category:RPM-based_Linux_distributions) like fedora uses [dnf](https://en.wikipedia.org/wiki/DNF_(software)) as their package manager. DNF was introduced in Fedora 18 (default since 22), Red Hat Enterprise Linux 8 and CentOS Linux 8. Command `dnf install` is used to install packages in fedora OS. For example, to install a [git](https://git-scm.com/), following command can be run:
``` bash
$ # Install git on Fedora using dnf
$ dnf install git
```
One of the alternatives to dnf is another package manager called [yum](https://en.wikipedia.org/wiki/Yum_(software)). However, this is the older version than dnf. `yum` is used in Fedora, CentOS 5 and above, Red Hat Enterprise Linux 5 and above, Scientific Linux, Yellow Dog Linux and Oracle Linux. For example, to install git using yum as a package manager, following command can be run: 
``` bash
$ # install git on Fedora using yum
$ yum install git
```
