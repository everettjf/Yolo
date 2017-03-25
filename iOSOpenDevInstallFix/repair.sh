
# fix Privateframeworks not exist
FrameworkLibraryPath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/
PrivateFrameworkLibraryPath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/PrivateFrameworks/

if [ ! -d "$PrivateFrameworkLibraryPath" ] ; then
    sudo ln -s $FrameworkLibraryPath $PrivateFrameworkLibraryPath
else
    echo "PrivateFrameworkLibraryPath ready"
fi

# fix simulator files not exist
SimulatorPath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Xcode/Specifications/
if [ ! -d "$SimulatorPath" ] ; then
    sudo mkdir $SimulatorPath
else
    echo "SimulatorPath ready"
fi
sudo cp -R ./Specifications/Simulator/ $SimulatorPath

# fix device files not exist
DevicePath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Specifications/
if [ ! -d "$DevicePath" ] ; then
    sudo mkdir $DevicePath
else
    echo "DevicePath ready"
fi
sudo cp -R ./Specifications/Device/ $DevicePath

# fix iosod not exit
binPath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin
sudo mkdir -p $binPath

echo "Complete"

