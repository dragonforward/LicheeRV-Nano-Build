#!/usr/bin/env sh
# a sd image generator
# usage
if [ "$#" -ne "1" ]
then
	echo "usage: sudo ./sd_gen_burn_image_rootless.sh OUTPUT_DIR"
	echo ""
	echo "       The script is used to create a sdcard image with two partitions, "
	echo "       one is fat32 with 16MB, the other is decide by your rootfs.sd."
	echo ""
	echo "Note:  Please backup you sdcard files before using this image!"

	exit
fi

output_dir=$1
echo ${output_dir}
set -eu
image=`LC_ALL=C date | tr -d '( ):'`.img
THISDIR=$(dirname $(realpath $0))
mkdir -pv ${output_dir}/tmp/
mkdir -pv ${output_dir}/root/
mkdir -pv ${output_dir}/input/
mkdir -pv ${output_dir}/input/rawimages/
cp -fv ${output_dir}/fip.bin ${output_dir}/input/
cp -fv ${output_dir}/rawimages/boot.sd ${output_dir}/input/rawimages/
cp -fv ${output_dir}/rawimages/rootfs.sd ${output_dir}/input/
cp -fv ${THISDIR}/genimage_rootless.cfg ${output_dir}/genimage.cfg
sed -i -e "s/duo.img/${image}/g" ${output_dir}/genimage.cfg
cd ${output_dir}/
${THISDIR}/genimage
echo ""
echo ""
echo ""
echo ""
echo "--------------->8------------------"
echo "# please use win32diskimager or dd command write it into sdcard"
echo ""
echo ""
realpath ${output_dir}/images/${image}
echo ""
echo ""
echo "--------------->8------------------"
exit $?