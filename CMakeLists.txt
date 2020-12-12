# Build for markturn

cmake_minimum_required(VERSION 3.18.4)

project(markturn)

option (LINK_STATIC "Build with static library" OFF)

# find LibXml2
find_package(LibXml2 REQUIRED)
message("-- libxml2 include: " ${LIBXML2_INCLUDE_DIR})
message("-- libxml2 library: " ${LIBXML2_LIBRARY})

# find CURL
find_package(CURL REQUIRED)
message("-- curl include: " ${CURL_INCLUDE_DIR})
message("-- curl library: " ${CURL_LIBRARY})

# find YAML
# @NOTE Should use find_package() as it can work, and adjust from there.
# @NOTE At least comment why you are not using it.
set(YAML_CPP_DIR /usr/include/yaml-cpp)
message("-- YAML include: " ${YAML_CPP_DIR})

# find JSON
# @NOTE Should use find_package() as it can work, and adjust from there.
# @NOTE At least comment why you are not using it.
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
# @NOTE Optional to use parentheses, unless space in name
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

# run // -h ouput help command # @NOTE Be consistent on capitalization of comments
add_custom_target(run DEPENDS markturn COMMAND ./markturn -h)

# Markturn test program
enable_testing()

# all .cpp files in test/ are independent test programs
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
