#!/bin/bash
unset dir
unset dir2
pwd
dir = $? 
cp $dir/*.img /tmp ; cp $dir/*.list /tmp ; cp $dir/*.dat /tmp ;
cd /tmp
pwd
dir2 = $?
git clone https://kkgithub.com/erfanoabdi/imgpatchtools.git ; cd imgpatchtools ; make ; cp -r bin/ ../ ; cd ..
bin/BlockImageUpdate system.img system.transfer.list system.new.dat system.patch.dat
bin/BlockImageUpdate product.img product.transfer.list product.new.dat product.patch.dat
bin/BlockImageUpdate vendor.img vendor.transfer.list vendor.new.dat vendor.patch.dat

cp $dir2/*.img $dir
rm $dir/*.list ; rm $dir/*.dat
cd $dir
pwd
ls -l
echo "Creating System,vendor,product Image Done"
