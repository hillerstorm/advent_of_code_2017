project(Day23)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

configure_file(config.h.in config.h)

add_executable(${PROJECT_NAME} "${PROJECT_NAME}.cpp" input.txt config.h.in)
