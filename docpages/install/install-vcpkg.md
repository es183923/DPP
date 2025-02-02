\page install-vcpkg Installing from VCPKG (Windows, Linux, OSX)

To install D++ on a system from VCPKG:

- Ensure VCPKG is correctly installed, and run `vcpkg integrate install` to integrate it with your build system.
- From a command line, type `vcpkg install dpp`
\image html vcpkg.png
- VCPKG will install the library and dependencies for you! Once completed you will receive a message indicating success:

- Use `vcpkg list dpp` to check that the package is installed:
```
c:\vcpkg>vcpkg list dpp
dpp:x64-windows                                    10.0.15          D++ Extremely Lightweight C++ Discord Library.
```
- You may now use the library within a `cmake` based project by adding instructions such as these to your `CmakeLists.txt`:
```cmake
    find_package(dpp CONFIG REQUIRED)
    target_link_libraries(your_target_name PRIVATE dpp::dpp)
```
