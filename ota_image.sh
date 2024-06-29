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
bin/BlockImageUpdate odm.img odm.transfer.list odm.new.dat odm.patch.dat
bin/BlockImageUpdate vendor_dlkm.img vendor_dlkm.transfer.list vendor_dlkm.new.dat vendor_dlkm.patch.dat
bin/BlockImageUpdate system_ext.img system_ext.transfer.list system_ext.new.dat system_ext.patch.dat
bin/BlockImageUpdate odm_dlkm.img odm_dlkm.transfer.list odm_dlkm.new.dat odm_dlkm.patch.dat


cp $dir2/*.img $dir
rm $dir/*.list ; rm $dir/*.dat
cd $dir
pwd
ls -l
echo "Compositing Images Done"
