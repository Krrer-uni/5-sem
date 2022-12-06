cmake_minimum_required(VERSION 3.23)
project(Calc)
find_package(BISON)
find_package(FLEX)

BISON_TARGET(MyParser calc.y ${CMAKE_CURRENT_BINARY_DIR}/calc.c)
FLEX_TARGET(MyScanner calc.l  ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp)
ADD_FLEX_BISON_DEPENDENCY(MyScanner MyParser)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_executable(calc
        calc.cpp
        my_arithmetic.c
        ${BISON_MyParser_OUTPUTS}
        ${FLEX_MyScanner_OUTPUTS}
        )
target_link_libraries(calc ${FLEX_LIBRARIES})