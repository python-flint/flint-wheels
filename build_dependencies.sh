#! /bin/sh

set -e -x

if [ -n "$IS_OSX" ]; then
    brew install homebrew/science/arb
else
    local PLATFORM_ARGS=--enable-fat
    
    wget http://mpir.org/mpir-2.7.0.tar.bz2
    tar -xf mpir-2.7.0.tar.bz2
    cd mpir-2.7.0
    ./configure --enable-gmpcompat --prefix=$HOME/deps --disable-static $PLATFORM_ARGS
    make -j4 > /dev/null 2>&1
    make install
    cd ..

    wget http://www.mpfr.org/mpfr-3.1.4/mpfr-3.1.4.tar.bz2
    tar -xf mpfr-3.1.4.tar.bz2
    cd mpfr-3.1.4
    ./configure --with-gmp=$HOME/deps --prefix=$HOME/deps --disable-static $PLATFORM_ARGS
    make -j4 > /dev/null 2>&1
    make install
    cd ..

    wget http://flintlib.org/flint-2.5.2.tar.gz
    tar -xf flint-2.5.2.tar.gz
    cd flint-2.5.2
    ./configure --with-gmp=$HOME/deps --with-mpfr=$HOME/deps --prefix=$HOME/deps --disable-static
    make -j4 > /dev/null 2>&1
    make install
    cd ..

    cd arb
    ./configure --with-mpir=$HOME/deps --with-mpfr=$HOME/deps --with-flint=$HOME/deps --prefix=$HOME/deps
    make -j4
    make install
    cd ..

    export LIBRARY_PATH=$LIBRARY_PATH:/root/deps/lib:/root/deps/lib/flint
    export INCLUDE_PATH=$INCLUDE_PATH:/root/deps/include:/root/deps/include/flint

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBRARY_PATH
    export LD_INCLUDE_PATH=$LD_INCLUDE_PATH:$INCLUDE_PATH
fi
