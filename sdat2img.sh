
# 仅在全量包——>镜像文件 阶段使用
python3 sdat2img.py system.transfer.list system.new.dat system.img
python3 sdat2img.py vendor.transfer.list vendor.new.dat vendor.img
python3 sdat2img.py product.transfer.list product.new.dat product.img
ls -l
echo system,vendor,product Created
sleep 2s
echo Now start the clean progress
rm ./*.list ; rm ./*.dat ; rm ./*.br
ls -l
echo Success.The Script will exited in 10s
sleep 10s

