add_executable(allocator_tester allocator_tester.cc)
target_link_libraries(allocator_tester PRIVATE Threads::Threads)
target_compile_options(allocator_tester
    PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/bigobj>
)
add_test(NAME allocator_tester COMMAND allocator_tester)

