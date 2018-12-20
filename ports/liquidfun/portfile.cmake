include(vcpkg_common_functions)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    message("LiquidFun only supports building as a static library")
    set(VCPKG_LIBRARY_LINKAGE "static")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/liquidfun
    REF v1.1.0
    SHA512 89a57f86643ba08c1b437aea626345e0b72265a85b52dfda217562d749f84a328fefb67dfdffd6c2103ba21401a796ae1beb9121a45380cc61295f0e63382519
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-liquidfun TARGET_PATH share/unofficial-liquidfun)

file(
    COPY ${SOURCE_PATH}/liquidfun/Box2D/Box2D
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
    FILES_MATCHING PATTERN "*.h"
)
file( REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/Box2D/Documentation )

vcpkg_copy_pdbs()

file(COPY ${SOURCE_PATH}/liquidfun/Box2D/License.txt ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/liquidfun)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/liquidfun/License.txt ${CURRENT_PACKAGES_DIR}/share/liquidfun/copyright)
