# executer pour compilation

clear

cd /Users/mattlawer/Desktop/Developer/iPhone/JBDev/Tweaks/lsbattery/
#ln -s /Users/mattlawer/Desktop/Developer/iPhone/JBDev/theos ./theos

make -f Makefile

mkdir -p ./layout/DEBIAN
cp ./control ./layout/DEBIAN

mkdir -p ./layout/Library/PreferenceLoader/Preferences
cp ./LSBatteryPreferences/entry.plist ./layout/Library/PreferenceLoader/Preferences/LSBatteryPreferences.plist

mkdir -p ./layout/Library/PreferenceBundles/LSBatteryPreferences.bundle
cp ./LSBatteryPreferences/Resources/*.* ./layout/Library/PreferenceBundles/LSBatteryPreferences.bundle
cp ./LSBatteryPreferences/obj/LSBatteryPreferences ./layout/Library/PreferenceBundles/LSBatteryPreferences.bundle

mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries
cp ./obj/LSBattery.dylib ./layout/Library/MobileSubstrate/DynamicLibraries
cp ./LSBattery.plist ./layout/Library/MobileSubstrate/DynamicLibraries


sudo find ./ -name ".DS_Store" -depth -exec rm {} \;

export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

dpkg-deb -b layout
mv ./layout.deb ./LSBattery.deb
