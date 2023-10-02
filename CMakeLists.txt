cmake_minimum_required(VERSION 3.8)

if(POLICY CMP0090)
    cmake_policy(SET CMP0090 NEW)
endif()

project(Cougar VERSION 1.0.0 LANGUAGES CXX)

option(HMCGR_TESTING "Enable testing" OFF)
## option(HMCGR_EXAMPLES "Build Examples" OFF)
## option(HMCGR_BENCHMARKS "Build Benchmarks" OFF)

if(HMCGR_TESTING)
    enable_testing()
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)

include(CheckSymbolExists)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

include(HMCGRTargetDataFiles)

# Build Cougar library
check_symbol_exists(clock_gettime "time.h" HMCGR_HAVE_CLOCK_GETTIME)

find_package(Threads REQUIRED)

# Installation

install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/Cougar
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT dev
)

## pkgconfig file
if(UNIX AND NOT APPLE)
    set(TAADPOOL_PKG_EXTRA_LIBS " -lpthread -lrt")
endif()

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Cougar.pc.in
    Cougar.pc
    @ONLY
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/Cougar.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

## CMake config files
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/CougarConfig.cmake.in
    CougarConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Cougar
)

write_basic_package_version_file(
    CougarConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    EXPORT CougarExport
    NAMESPACE Cougar::
    FILE CougarTargets.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Cougar
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/CougarConfig.cmake
          ${CMAKE_CURRENT_BINARY_DIR}/CougarConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Cougar
)

export(PACKAGE Cougar)

# Tests
if(HMCGR_TESTING)
    add_subdirectory(test)
endif()

