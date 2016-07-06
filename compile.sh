#!/bin/bash

# __author__ = "Alberto Pettarin"
# __copyright__ = "Copyright 2015-2016, Alberto Pettarin (www.albertopettarin.it)"
# __license__ = "MIT"
# __version__ = "1.0.1"
# __email__ = "alberto@albertopettarin.it"
# __status__ = "Production"

CURRENT_DIR=`pwd`
DIR="/tmp/espeakosx"
INNER_SRC_DIR="espeak-1.48.04-source/src"

if [ $# -lt 2 ]
then
    echo ""
    echo "Usage:"
    echo "  $ bash compile.sh /path/to/pa_stable_v19_20140130.tgz /path/to/espeak-1.48.04-source.zip "
    echo ""
    exit 2
fi

PORTAUDIO_SOURCE_ZIP=$1
ESPEAK_SOURCE_ZIP=$2

if ! [ -e "$PORTAUDIO_SOURCE_ZIP" ]
then
    echo "[ERRO] File $PORTAUDIO_SOURCE_ZIP not existing. Please specify the path of pa_stable_v19_20140130.tgz"
    exit 1
fi
if ! [ -e "$ESPEAK_SOURCE_ZIP" ]
then
    echo "[ERRO] File $ESPEAK_SOURCE_ZIP not existing. Please specify the path of espeak-1.48.04-source.zip"
    exit 1
fi

# we will work in $DIR
echo "[INFO] Creating $DIR ..."
rm -rf $DIR
mkdir $DIR

# copy patch files in $DIR
echo "[INFO] Copying patch files..."
cp *.patch $DIR

# copy espeak ZIP in $DIR
cp "$PORTAUDIO_SOURCE_ZIP" "$DIR/pa.tgz"
cp "$ESPEAK_SOURCE_ZIP" "$DIR/ess.zip"

# cd there
cd $DIR

## get portaudio source from http://www.portaudio.com/download.html :
#echo "[INFO] Downloading portaudio..."
#curl "http://www.portaudio.com/archives/pa_stable_v19_20140130.tgz" > pa.tgz

# extract, configure, compile
echo "[INFO] Compiling portaudio..."
tar xzf pa.tgz
cd portaudio
patch -i ../portaudio_configure_sdk.patch
./configure && make

if ! [ -e "lib/.libs/libportaudio.a"  ]
then
    echo "[ERRO] Error while compiling portaudio, aborting."
    cd $CURRENT_DIR
    exit 1
fi

# go back to $DIR
cd $DIR

# get espeak source
echo "[INFO] Unzipping espeak..."
unzip ess.zip

# patch source files
if ! [ -e "$INNER_SRC_DIR" ]
then
    echo "[ERRO] Unable to enter directory $INNER_SRC_DIR, aborting."
    cd $CURRENT_DIR
    exit 1
fi

echo "[INFO] Patching source files..."
cd $INNER_SRC_DIR
patch Makefile $DIR/Makefile.patch
patch event.cpp $DIR/event.cpp.patch
patch fifo.cpp $DIR/fifo.cpp.patch

# copy the static library libportaudio.a here
cp $DIR/portaudio/lib/.libs/libportaudio.a .

# overwrite portaudio.h
cp $DIR/portaudio/include/portaudio.h .

# compile
echo "[INFO] Compiling espeak..."
make

if [ -e "libespeak.so" ]
then
    echo "[INFO] Success! The compiled espeak files are located in $DIR/$INNER_SRC_DIR"
else
    echo "[ERRO] Error while compiling espeak"
    cd $CURRENT_DIR
    exit 1
fi

cd $CURRENT_DIR
exit 0
