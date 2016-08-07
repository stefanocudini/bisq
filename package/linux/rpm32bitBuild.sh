#!/bin/bash

cd ../../
mkdir -p gui/deploy

set -e

# Edit version
version=0.4.9.3

jarFile="/media/sf_vm_shared_ubuntu14_32bit/Bitsquare-$version.jar"
jdkfixFile="/media/sf_vm_shared_ubuntu14_32bit/jdkfix-$version.jar"

# Note: fakeroot needs to be installed on linux
$JAVA_HOME/bin/javapackager \
    -deploy \
    -BjvmOptions=-Xbootclasspath/a:"jdkfix-$version.jar":"../runtime/lib/ext/jfxrt.jar" \
    -Bruntime="$JAVA_HOME/jre" \
    -BappVersion=$version \
    -Bcategory=Internet \
    -Bemail=team@bitsquare.io \
    -BlicenseType=GPLv3 \
    -BlicenseFile=LICENSE \
    -Bicon=package/linux/icon.png \
    -native rpm \
    -name Bitsquare \
    -title Bitsquare \
    -vendor Bitsquare \
    -outdir gui/deploy \
    -srcfiles $jarFile:$jdkfixFile \
    -srcfiles package/linux/LICENSE \
    -appclass io.bitsquare.app.BitsquareAppMain \
    -outfile Bitsquare

rm gui/deploy/Bitsquare.html
rm gui/deploy/Bitsquare.jnlp
rm gui/deploy/LICENSE
mv "gui/deploy/bundles/bitsquare-$version.rpm" "gui/deploy/Bitsquare-32bit-$version.rpm"
rmdir gui/deploy/bundles
cp "gui/deploy/Bitsquare-32bit-$version.rpm" "/media/sf_vm_shared_ubuntu14_32bit/Bitsquare-32bit-$version.rpm"
cp "gui/deploy/Bitsquare-32bit-$version.rpm" "/home/bitsquare/Desktop/Bitsquare-32bit-$version.rpm"

cd package/linux