#!/bin/bash

#Config options
export BUILD_TYPE=dev
export SRC_ROOT=/home/albinoman887/cm-11
export WEB_ROOT=/var/www/html
export MEGA_ROOT=/Root/html

#######################################################################################

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
megasync -l $WEB_ROOT/$DEVICE/$BUILD_TYPE -r /$MEGA_ROOT/$DEVICE/$BUILD_TYPE
}

#######################################################################################

#Get time
time_start=$(date +%s.%N)

DEVICE=klteusc
DoBuild
SetupDownloads

#echo total build time
time_end=$(date +%s.%N)
echo -e "${BLDYLW}Total time elapsed: ${TCTCLR}${TXTGRN}$(echo "($time_end - $time_start) / 60"|bc ) ${TXTYLW}minutes${TXTGRN} ($(echo "$time_end - $time_start"|bc ) ${TXTYLW}seconds) ${TXTCLR}"
