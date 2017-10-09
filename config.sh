# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    source ./build_dependencies.sh

    # Now go into the project directory and run a custom build_ext command
    cd python-flint
    python -m pip install cython
    python setup.py build_ext \
        --include-dirs=/root/deps/include:/root/deps/include/flint \
        --library-dirs=/root/deps/lib:/root/deps/lib/flint
    cd ..
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/deps/lib:/root/deps/lib/flint
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    :
}
