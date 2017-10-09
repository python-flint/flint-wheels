# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    source ./build_dependencies.sh
    
    # Now go into the project directory and run a custom build_ext command
    cd python-flint
    python setup.py build_ext --include-dirs=$LD_INCLUDE_PATH --library-dirs=$LD_LIBRARY_PATH
    cd ..
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    :
}
