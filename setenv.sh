#!/bin/bash

## Set CMT
if [ -z "$CMTROOT" ]; then
    ## change the path to your own CMT
    source /opt/heps/CMT/v1r26p20160527/mgr/setup.sh
    if [ $? -ne 0 ]; then
        echo "Failed to set the CMT"
        return 1
    fi
fi

## Set ROOT
if [ -z "$ROOTSYS" ]; then
    ## change the path to your own ROOT
    source /opt/heps/root/v6.10.08/bin/thisroot.sh
    if [ $? -ne 0 ]; then
        echo "Failed to set the ROOT"
        return 1
    fi
fi

AbsThisName=`readlink -f ${BASH_SOURCE[0]}`
AbsPrjDir=`dirname "$AbsThisName"`
if [ ! -d $AbsPrjDir/sniper ]; then
    echo "Please checkout the sniper project first"
    return 1
fi

export CMTPROJECTPATH=$AbsPrjDir

pushd $AbsPrjDir/sniper/SniperRelease/cmt
    if [ ! -f setup.sh ]; then
        cmt config
    fi
    source setup.sh
popd
