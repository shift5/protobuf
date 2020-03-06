set(protoc_files
  ${protobuf_source_dir}/src/google/protobuf/compiler/main.cc
)

if (MSVC)
set(protoc_rc_files
  ${CMAKE_CURRENT_BINARY_DIR}/version.rc
)
endif()

add_executable(protoc ${protoc_files} ${protoc_rc_files})
# Clang x86 requires atomic lib
if (${CMAKE_SIZEOF_VOID_P} EQUAL 4 AND "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" AND NOT ${CMAKE_LIBRARY_ARCHITECTURE})
  target_link_libraries(protoc libprotobuf libprotoc atomic)
else ()
  target_link_libraries(protoc libprotobuf libprotoc)
endif ()
add_executable(protobuf::protoc ALIAS protoc)

set_target_properties(protoc PROPERTIES
    VERSION ${protobuf_VERSION})
