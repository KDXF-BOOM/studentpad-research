#!/bin/bash

# 初始化变量
unset system_root
unset condition
unset Image
unset Fast

echo '***********************************************************'
echo '*  System.img Modification Script                         *'
echo '*                                                         *'
echo '*The Script was Created By "Leaves,KawaiiSparkle,ChatGPT" *'
echo '*Prepared For Iflytek Pad   Ver Pre                       *'
echo '*   Only tested on Iflytek X2 Pro                         *'
echo '*       Only tested on Ubuntu                             *'
echo '***********************************************************'
echo 
echo '******************************************************************************'
echo '*Installng Basic Runtime Environment and Checking Basic Folder "system-root" *'
echo '******************************************************************************'
echo 

# 检查system-root
if [ -d "./system-root" ]; then
    echo 'Find the folder "system-root" in the current directory'
    echo 'Do you want to use it or manually type in another folder address ?'
    echo 'U)se it  T)ype manually  [input U/T]'
    read condition
    if [ "$condition" = "U" ]; then
        system_root="./system-root"
    elif [ "$condition" = "T" ]; then
        read -p "Please enter the system-root path: " system_root
        if [ ! -d "${system_root}/.." ]; then
            echo "Invalid folder path. Exiting in 5s."
            sleep 5
            exit 1
        fi
    else
        echo "Invalid input. Exiting in 5s."
        sleep 5
        exit 1
    fi
else
    echo 'Error: Cannot find important folder "system-root"'
    echo 'You may need to download this folder or manually type in folder address.'
    echo 'D)ownload it  T)ype manually  [input D/T]'
    read condition
    if [ "$condition" = "D" ]; then
        echo 'Choose a download link'
        echo 'G)ithub A)list C)ustomizable-Github'
        read condition
        if [ "$condition" = "G" ]; then
            wget https://github.com/KDXF-BOOM/studentpad-research/blob/System-Image-Patch-Script/system-root.zip
            rm -r ./system-root
            mkdir ./system-root
            unzip -o system-root.zip -d ./system-root
            system_root="./system-root"
        elif [ "$condition" = "A" ]; then
            wget https://kdxf.work/d/system-root/system-root.zip
            rm -r ./system-root
            mkdir ./system-root
            unzip -o system-root.zip -d ./system-root
            system_root="./system-root"
        else
            read -p "Please enter the file acceleration link, for example 'https://github.moeyy.xyz/': " Fast
            wget ${Fast}https://github.com/KDXF-BOOM/studentpad-research/blob/System-Image-Patch-Script/system-root.zip
            rm -r ./system-root
            mkdir ./system-root
            unzip -o system-root.zip -d ./system-root
            system_root="./system-root"
        fi
    elif [ "$condition" = "T" ]; then
        read -p "Please enter the folder path: " system_root
        if [ ! -d "${system_root}/.." ]; then
            echo "Invalid folder path. Exiting in 5s."
            sleep 5
            exit 1
        fi
    else
        echo "Invalid input. Exiting in 10s."
        sleep 10
        exit 1
    fi
fi

# 检查Image
if [ -w "./system.img" ]; then
    echo 'Find the Image "system.img" in the current directory'
    echo 'Do you want to use it or manually type in another image address ?'
    echo 'U)se it  T)ype manually  [input U/T]'
    read condition
    if [ "$condition" = "U" ]; then
        Image="./system.img"
    elif [ "$condition" = "T" ]; then
        read -p "Please enter the image path: " Image
        if [ ! -w "${Image}" ]; then
            echo "Invalid Image Path, the script will be exited in 5s."
            sleep 5
            exit 1
        fi
    else
        echo "Invalid input. Exiting in 10s."
        sleep 10
        exit 1
    fi
else
    echo 'Error: Cannot find the Image'
    echo 'You may need to manually type in image address.'
    echo 'E)xit  T)ype manually  [input E/T]'
    read condition
    if [ "$condition" = "E" ]; then
        exit
    elif [ "$condition" = "T" ]; then
        read -p "Please type the image path: " Image
        if [ ! -w "${Image}" ]; then
            echo "Invalid Image Path, the script will be exited in 5s."
            sleep 5
            exit 1
        fi
    else
        echo "Invalid input. Exiting in 10s."
        sleep 10
        exit 1
    fi
fi

# 备份和挂载Image
echo
echo '***************************************************************'
echo '*Will mount the image "System.img",Do you want to backup it ? *'
echo "*  Y)es,I want to backup it.  N)o,I don't need to backup it.  *"
echo '***************************************************************'
read backup
if [ "$backup" = "Y" ]; then
    cp ${Image}  ${Image}.bak
    echo Backup Finish
elif [ "$backup" = "N" ]; then
    echo "The Image will not backup"
else
    echo 'Incorrect input,The script will be exited in 10s.'
    sleep 10
    exit
fi

echo
echo '*****************'
echo '*Mount the image*'
echo '*****************'
echo

if [ -w "./Temp" ]; then
    echo 'Folder "./Temp" conflict detected. Whether to delete the folder or not ?'
    echo "Y)es,I want to delete it.  N)o,It's important,don't modify it."
    read condition
    if [ "$condition" = "Y" ]; then
        sudo rm -r ./Temp
        mkdir ./Temp
    elif [ "$condition" = "N" ]; then
        echo 'No files have been modified,The script will be exited in 10s.'
        sleep 10
        exit
    else
        echo 'Incorrect input,The script will be exited in 10s.'
        sleep 10
        exit
    fi
else
    mkdir ./Temp
fi

# modprobe loop
# sudo losetup -f > .Temp.log
# sudo cat .Temp.log
# loop=$(sed -n '1p' ./.Temp.log)
# sudo kpartx -av ${Image}
# sudo mount ${loop}p1 ./Temp
# sudo rm .Temp.log
mkdir -p Temp/system
mount -o rw ${Image} Temp
system=./Temp/system 

# 复制和修改文件
echo 
echo '***************************************'
echo '*Copying of required files in progress*'
echo '***************************************'

sudo cp ./system-root/bin/magisk  ${system}/bin/magisk
sudo cp ./system-root/bin/magiskpolicy ${system}/bin/magiskpolicy
sudo cp ./system-root/init/magisk.rc ${system}/etc/init/magisk.rc
sudo cp -r ./system-root/magisk ${system}/etc/init
sudo chmod 0700 -R ${system}/etc/init/magisk
sudo chown -R 0 ${system}/etc/init/magisk
sudo chcon -R -h u:object_r:system_file:s0 ${system}/etc/init/magisk
mkdir ${system}/../data/adb
sudo cp -r ./system-root/data-magisk ${system}/../data/adb

echo
echo '***********************************'
echo '*Backing up the file "bootanim.rc"*'
echo '***********************************'
echo

sudo gzip ${system}/etc/init/bootanim.rc

echo
echo '**********************************'
echo '*Modifying the file "bootanim.rc"*'
echo '**********************************'
echo

sudo cat > ${system}/etc/init/bootanim.rc <<eof
service bootanim /system/bin/bootanimation
    class core animation
    user graphics
    group graphics audio
    disabled
    oneshot
    writepid /dev/stune/top-app/tasks

on post-fs-data
    start logd
    exec u:r:su:s0 root root -- /system/etc/init/magisk/magiskpolicy --live --magisk
    exec u:r:magisk:s0 root root -- /system/etc/init/magisk/magiskpolicy --live --magisk
    exec u:r:update_engine:s0 root root -- /system/etc/init/magisk/magiskpolicy --live --magisk
    exec u:r:su:s0 root root -- /system/etc/init/magisk/magisk64 --auto-selinux --setup-sbin /system/etc/init/magisk /sbin
    exec u:r:su:s0 root root -- /sbin/magisk --auto-selinux --post-fs-data

on nonencrypted
    exec u:r:su:s0 root root -- /sbin/magisk --auto-selinux --service

on property:vold.decrypt=trigger_restart_framework
    exec u:r:su:s0 root root -- /sbin/magisk --auto-selinux --service

on property:sys.boot_completed=1
    mkdir /data/adb/magisk 755
    exec u:r:su:s0 root root -- /sbin/magisk --auto-selinux --boot-complete
   
on property:init.svc.zygote=restarting
    exec u:r:su:s0 root root -- /sbin/magisk --auto-selinux --zygote-restart
   
on property:init.svc.zygote=stopped
    exec u:r:su:s0 root root -- /sbin/magisk --auto-selinux --zygote-restart

eof

echo "persist.service.adb.enable=1\\npersist.sys.usb.config=diag,adb,mtp\\nro.sys.usb.default.config=diag,adb,mtp" >> ./Temp/system/build.prop

echo '***************************'
echo '* Umount the "System.img" *'
echo '***************************'
echo

sudo umount ${Image}

echo '**********************************'
echo '*Cleaning up temporary files now.*'
echo '**********************************'
echo 

unset Fast
unset Image
unset condition
unset system_root

if [ -e ./system-root.zip ]; then
    sudo rm system-root.zip
    echo 
else
    echo 
fi

sudo rm -r ./Temp

echo '************************************************************'
echo '*Patch System Partitiion Progress Completed,Congratulations!*'
echo '************************************************************'
sleep 10
echo '************************************************************'
echo '*Patch Vendor Partitiion Progress Started,Wish U Good Luck**'
echo '************************************************************'
if [-d "./vendor"]
    echo vendor is already created before,continue
else
    echo there isn't a vendor floder,we'll create it
    mkdir vendor
fi

sudo mount -o rw vendor.img vendor
ls -l vendor
wget -O 'magisk_vendor.zip' 'https://kdxf.work/d/magisk_vendor.zip'
# wget -O 'magisk_vendor.zip' 'https://github.moeyy.xyz/https://raw.githubusercontent.com/KDXF-BOOM/studentpad-research/System-Image-Patch-Script/magisk_vendor.zip' 如果第一个不能用再启用
unzip magisk_vendor.zip
sudo chmod +x ./libmagiskinit.so 
sudo cp vendor/etc/selinux/precompiled_sepolicy precompiled_sepolicy
gzip precompiled_sepolicy
sudo cp precompiled_sepolicy.gz vendor/etc/selinux/precompiled_sepolicy.gz
sudo rm precompiled_sepolicy.gz
sudo mv precompiled_sepolicy sepol.in
sudo ./libmagiskinit.so --patch-sepol sepol.in sepol.out
ls -l | grep sepol.out
sudo cp sepol.out vendor/etc/selinux/precompiled_sepolicy
echo '***************************'
echo '* Umount the "vendor.img" *'
echo '***************************'
echo
sudo umount vendor.img
echo '***************************'
echo '*Vendor Patch Done Successful." *'
echo '***************************'