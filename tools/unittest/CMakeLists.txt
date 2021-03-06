project(unittest)

include_directories( ${LOOM_INCLUDE_FOLDERS} )

set (UNITTEST_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp)
add_executable(unittest ${UNITTEST_SRC})

if (MSVC)
    set (EXTRA_LIBS "kernel32" "advapi32" "COMCTL32" "COMDLG32" "USER32" "ADVAPI32" "GDI32" "WINMM" "OPENGL32" "WSOCK32" "Ws2_32")
else ()
    set (EXTRA_LIBS -lpthread)
endif()

target_link_libraries(unittest
    LoomVendor
    LoomCommon
    LoomScript
    LoomCore
    ${EXTRA_LIBS}
)

set(UNITTESTBIN $<TARGET_FILE:${PROJECT_NAME}>)

if (LOOM_BUILD_64BIT EQUAL 1)
    set(UNITTESTBIN_DEST unittest-x64)
else()
    set(UNITTESTBIN_DEST unittest-x86)
endif()

if (MSVC)

    add_custom_command(TARGET unittest
        POST_BUILD
        COMMAND echo f | xcopy /F /Y \"${UNITTESTBIN}\" \"${CMAKE_SOURCE_DIR}/tests/${UNITTESTBIN_DEST}.exe\"
    )

else ()

    add_custom_command(TARGET unittest
        POST_BUILD
        COMMAND mkdir -p ${CMAKE_SOURCE_DIR}/tests
        COMMAND cp ${UNITTESTBIN} ${CMAKE_SOURCE_DIR}/tests/${UNITTESTBIN_DEST}
    )

endif()

if (LOOM_BUILD_JIT EQUAL 1)
    target_link_libraries(unittest luajit)

    if (LINUX)
        target_link_libraries(${PROJECT_NAME} -ldl)
    endif()
endif()

