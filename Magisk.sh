#!/bin/bash
unset system_root
unset condition
unset Image
unset Fast

echo '*************************************'
echo '*  System.img Modification Script   *'
echo '*                                   *'
echo '*The Script was Created By "Leaves" *'
echo '*Prepared For Iflytek Pad   Ver Pre *'
echo '*   Only tested on Iflytek X2 Pro   *'
echo '*       Only tested on Ubuntu       *'
echo '*************************************'
echo 
echo '******************************************************************************'
echo '*Installng Basic Runtime Environment and Checking Basic Folder "system-root" *'
echo '******************************************************************************'
echo 
#sudo apt update
#sudo apt install kpartx wget unzip mount coreutils -y

#system=/root/Temp/system
#
#if test -d ./system-root
#then
#    echo 'Find the folder "system-root" in the current directory'
#    echo 'Do you want to use it or manually type in another folder address ?'
#    echo 'U)se it  T)ype manually  [input U/T]'
#    read condition
#    if test ${condition} = U
#     then
#      echo 'Will use the "system-root folder in ./"'
#      system-root=./system-root
#    else
#      if test ${condition} = T
#       then
#        echo 'Please type the file path'
#        read system-root 
#        echo 'Testing folder path for validity'
#        if test -d ${system-root}
#         then
#          echo 'Passed'
#         else
#          echo 'Error: Cannot find the folder "system-root" in ${system-root}/.."'
#          echo 'Invalid Folder Path, this script will be exited in 20s.'
#          sleep 20
#          exit
#        fi
# else
#    echo 'Incorrect input,The script will be exited in 10s.'
#    sleep 10
#    exit
# fi
#fi

if test -d ./system-root
then
    echo 'Find the folder "system-root" in the current directory'
    echo 'Do you want to use it or manually type in another folder address ?'
    echo 'U)se it  T)ype manually  [input U/T]'
    unset condition
    read condition
    if test ${condition} = U
     then
      echo 'Will use the "system-root" folder in ./"'
      unset system_root
      system_root=./system-root
     else
      if test ${condition} = T
       then
        echo 'Please type the folder path'
        unset system_root
        read system_root 
        echo 'Testing folder path for validity'
        if test -d ${system_root}/../system-root
         then
          echo 'Test Passed'
         else
#         echo Error: Cannot find the folder "system-root" in ${system_root}
          echo 'Invalid Folder Path, this script will be exited in 5s.'
          sleep 5
          exit
        fi
       else
        echo 'Incorrect input,The script will be exited in 5s.'
        sleep 5
        exit
      fi
    fi
else
    echo 'Error: Cannot find important folder "system-root"'
    echo 'You may need to download this folder or manually type in folder address.'
    echo 'D)ownload it  T)ype manually  [input D/T]'
    unset condition
    read condition
     if test ${condition} = D
      then
       echo 'Choose a download link'
       echo 'G)ithub A)list C)ustomizable-Github'
       unset condition
       read condition
       if test ${condition} = G
then
    wget https://github.com/KDXF-BOOM/studentpad-research/blob/System-Image-Patch-Script/system-root.zip
    rm -r ./system-root
    mkdir ./system-root
    unzip -o system-root.zip -d ./system-root
    unset system_root
    system_root=./system-root  
elif test ${condition} = A
then 
    wget https://kdxf.work/d/system-root/system-root.zip
    rm -r ./system-root
    mkdir ./system-root
    unzip -o system-root.zip -d ./system-root
    unset system_root
    system_root=./system-root  
else
    echo 'Please enter the file acceleration link,for example "https://github.moeyy.xyz/"'
    unset Fast
    read Fast
    wget ${Fast}https://github.com/KDXF-BOOM/studentpad-research/blob/System-Image-Patch-Script/system-root.zip
    rm -r ./system-root
    mkdir ./system-root
    unzip -o system-root.zip -d ./system-root
    unset system_root
    system_root=./system-root 
fi
     elif test ${condition} = T
       then
        echo 'Please type the folder path'
        unset system_root
        read system_root 
        echo 'Testing folder path for validity'
        if test -d ${system_root}/../system-root
         then
          echo 'Test Passed'
         else
#         echo Error: Cannot find the folder "system-root" in ${system_root}/..
          echo 'Invalid Folder Path, this script will be exited in 5s.'
          sleep 5
          exit
        fi
       else
        echo 'Incorrect input,The script will be exited in 10s.'
        sleep 10
        exit
 fi
fi

# if test -d ${system}
# then
#     echo 'Passed'
# else
#     echo 'Error: Cannot find important folder "${system}",Please check if the image is mounted correctly'
#     echo 'Base file is missing, this window will be closed in 20s.'
#     sleep 20
#     sudo poweroff
# fi

echo 
echo '*********************************************************************'
echo '* The folder "system-root" test passed,Modify the start of the task *'
echo '*********************************************************************'
echo
echo '*************************'
echo '*Check the System Image *'
echo '*************************'

# if test -e ./system.img
# then
#     echo 'Passed'
# else
#     echo 'Error: Cannot find important file "system.img",You may need to place the image in "./" manually.'
# fi

if test -w ./system.img
 then
  echo 'Find the Image "system.img" in the current directory'
  echo 'Do you want to use it or manually type in another image address ?'
  echo 'U)se it  T)ype manually  [input U/T]'
  unset condition
  read condition
    if test ${condition} = U
     then
      echo 'Will use the image "system.img" in ./"'
      unset Image
      Image=./system.img
    elif test ${condition} = T
     then 
       echo 'Please type the image path'
       unset Image
       read Image 
       echo 'Testing image path for validity'
        if test -w ${Image}
         then
          echo 'File and File Permissions Test Passed'
         else
#         echo Error: Cannot find the folder "system-root" in ${system_root}
          echo 'Invalid Image Path, the script will be exited in 5s.'
          sleep 5
          exit
        fi
    else
        echo 'Incorrect input,The script will be exited in 10s.'
        sleep 10
        exit
    fi
else
    echo 'Error: Cannot find the Image '
    echo 'You may need to manually type in image address.'
    echo 'E)xit  T)ype manually  [input E/T]'
    unset condition
    read condition
     if test ${condition} = E
      then
       exit
     elif test ${condition} = T
      then 
       echo 'Please type the image path'
       unset Image
       read Image 
       echo 'Testing image path for validity'
        if test -w ${Image}
         then
          echo 'File and File Permissions Test Passed'
        else
          echo 'Invalid Image Path, the script will be exited in 5s.'
          sleep 5
          exit
        fi
    else
        echo 'Incorrect input,The script will be exited in 10s.'
        sleep 10
        exit
    fi
fi

echo
echo '***************************************************************'
echo '*Will mount the image "System.img",Do you want to backup it ? *'
echo "*  Y)es,I want to backup it.  N)o,I don't need to backup it.  *"
echo '***************************************************************'
read backup
if test ${backup} = Y
 then
    cp ${Image}  ${Image}.bak
    echo Backup Finish
elif test ${backup} = N
 then 
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

if test -w ./Temp
     then
      echo 'Folder "./Temp" conflict detected. Whether to delete the folder or not ?'
      echo "Y)es,I want to delete it.  N)o,It's important,don't modify it."
      unset condition
      read condition      
      if test ${condition} = Y
       then
        sudo rm -r ./Temp
        mkdir ./Temp
      elif test ${condition} = N
       then
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

sudo losetup -f > .Temp.log 
sudo cat .Temp.log
loop=`sed -n '1p' ./.Temp.log `
sudo kpartx -av ${Image}
sudo mount ${loop} ./Temp
sudo rm .Temp.log 
system=./Temp/system

echo 
echo '***************************************'
echo '*Copying of required files in progress*'
echo '***************************************'
# system=/root/Temp/system
# ${system}

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

sudo cp ${system}/etc/init/bootanim.rc ${system}/etc/init/bootanim.rc.bak

echo
echo '**********************************'
echo '*Modifying the file "bootanim.rc"*'
echo '**********************************'
echo
# sudo nano ${system}/etc/init/bootanim.rc

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


echo '***************************'
echo '* Umount the "System.img" *'
echo '***************************'
echo

sudo umount ./Temp

echo '**********************************'
echo '*Cleaning up temporary files now.*'
echo '**********************************'
# echo 

unset Fast
unset Image
unset condition
unset system_root

if test -e ./system-root.zip
    then
      sudo rm system-root.zip
      echo 
    else
      echo 
    fi

# sudo rm .Temp.log 
# sudo rm -r ./Temp

echo '************************************************************'
echo '*Full Mandates Completed!This script will be exited in 10s.*'
echo '************************************************************'
sleep 10
exit
