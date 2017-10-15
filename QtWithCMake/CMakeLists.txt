cmake_minimum_required(VERSION 3.8)
project(QtWithCMakeDemo)


set(Qt5Core_DIR /Users/everettjf/qt/5.9.1/clang_64/lib/cmake/Qt5Core)
set(Qt5Gui_DIR /Users/everettjf/qt/5.9.1/clang_64/lib/cmake/Qt5Gui)
set(Qt5Widgets_DIR /Users/everettjf/qt/5.9.1/clang_64/lib/cmake/Qt5Widgets)

set(CMAKE_CXX_STANDARD 14)

SET(CMAKE_AUTOMOC ON)
SET(CMAKE_AUTOUIC ON)
SET(CMAKE_AUTORCC ON)
SET(CMAKE_INCLUDE_CURRENT_DIR ON)


FIND_PACKAGE(Qt5Core REQUIRED)
FIND_PACKAGE(Qt5Gui REQUIRED)
FIND_PACKAGE(Qt5Widgets REQUIRED)


set(SOURCE_FILES
        main.cpp
        MainWindow.cpp
        )

include_directories(
        ${Qt5Widgets_INCLUDES}
        ${Qt5Widgets_PRIVATE_INCLUDE_DIRS}
        ${Qt5Gui_INCLUDE_DIRS}
        ${Qt5Gui_PRIVATE_INCLUDE_DIRS}
)


add_executable(QtWithCMakeDemo ${SOURCE_FILES})

target_link_libraries(QtWithCMakeDemo  Qt5::Widgets Qt5::Gui)
