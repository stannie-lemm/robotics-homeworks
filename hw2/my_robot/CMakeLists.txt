cmake_minimum_required(VERSION 2.8.3)
project(my_robot)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  roslaunch
  robot_state_publisher
  rviz
  tf
)
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES intro_to_robotics
  CATKIN_DEPENDS roscpp std_msgs robot_state_publisher rviz tf
#  DEPENDS system_lib
)

include_directories(
include
  ${catkin_INCLUDE_DIRS}
)

add_executable(my_robot src/state_publisher.cpp)
target_link_libraries(my_robot ${catkin_LIBRARIES})
if(CATKIN_ENABLE_TESTING)
  find_package(roslaunch REQUIRED)
  roslaunch_add_file_check(launch)
endif()

install(DIRECTORY meshes launch rviz urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
