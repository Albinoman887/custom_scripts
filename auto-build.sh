#!/bin/bash

#Config options
export SRC_ROOT=/home/albinoman887/cm-11
export WEB_ROOT=/var/www/html
export MEGA_ROOT=/Root/html

#######################################################################################

export DEVICE="$1"
export BUILD_TYPE="$2"
export CURDATE=`date "+%m.%d.%Y"`
export PATH=~/bin:$PATH
export USE_CCACHE=1

function DoBuild()
{
cd $SRC_ROOT
. build/envsetup.sh
lunch cm_$DEVICE-userdebug
mka bacon
}

function SetupDownloads()
{
cd $SRC_ROOT/out/target/product/$DEVICE/
cp -r cm-11*.zip $WEB_ROOT/$DEVICE/$BUILD_TYPE/
megasync --reload -l $WEB_ROOT/$DEVICE/$BUILD_TYPE -r $MEGA_ROOT/$DEVICE/$BUILD_TYPE
}

#######################################################################################

#Set device
if [ "$1" = "" ]; then
clear
echo 
echo "No device set via cmdline, enter which device to build: "
echo
read DEVICE
fi

#Set build type
if [ "$2" = "" ]; then
clear
echo
echo "No build type set via cmdline, select build type (nightly/release/dev): "
echo
read BUILD_TYPE
fi

#print build config
echo
echo "Set DEVICE to: $DEVICE"
echo "Set BUILD TYPE to: $BUILD_TYPE"
echo

#Get time
time_start=$(date +%s.%N)

#Build and copy
DoBuild
SetupDownloads

#cleanup
cd $SRC_ROOT
make clobber

#Print total build time
time_end=$(date +%s.%N)
echo -e "${BLDYLW}Total time elapsed: ${TCTCLR}${TXTGRN}$(echo "($time_end - $time_start) / 60"|bc ) ${TXTYLW}minutes${TXTGRN} ($(echo "$time_end - $time_start"|bc ) ${TXTYLW}seconds) ${TXTCLR}"
