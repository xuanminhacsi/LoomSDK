project(lsc)

include_directories( ${LOOM_INCLUDE_FOLDERS} )

# Command line loom script compiler.

set (LSC_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp)
add_executable(lsc ${LSC_SRC})

if (MSVC)

    target_link_libraries(lsc
        LoomVendor
        LoomCommon
        LoomScript
        "kernel32" "advapi32" "COMCTL32" "COMDLG32" "USER32" "ADVAPI32" "GDI32" "WINMM" "OPENGL32" "WSOCK32" "Ws2_32" 
    )

    set(LSCBIN $<TARGET_FILE:lsc>)

    add_custom_command(TARGET lsc
        POST_BUILD
        COMMAND echo f | xcopy /F /Y \"${LSCBIN}\" \"${ARTIFACTS_DIR}/tools/lsc.exe\"
    )

else ()

    target_link_libraries(lsc
        LoomVendor 
        LoomCommon 
        LoomScript
        -lpthread
    )

    set(LSCBIN $<TARGET_FILE:lsc>)

    add_custom_command(TARGET lsc
        POST_BUILD
        COMMAND mkdir -p ${ARTIFACTS_DIR}/tools
        COMMAND cp ${LSCBIN} ${ARTIFACTS_DIR}/tools/lsc
    )

endif(MSVC)


if (LOOM_BUILD_JIT EQUAL 1)
    target_link_libraries(lsc luajit)

    if (LINUX)
        target_link_libraries(${PROJECT_NAME} -ldl)
    endif()

endif()

