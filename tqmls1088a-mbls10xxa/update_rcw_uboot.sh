#!/bin/bash
CNV_TOOL=/opt/tqmls10xxa-bsp/tools/rcw2uboot/rcw2uboot.py
CNV_OPT="-c ls1088a -d -s32"
UBOOT_PATH=/opt/tqmls10xxa-bsp/u-boot/board/tqc/tqmls1088a/pbi_rcw

for SRDS1 in "3333"; do
	for SRDS2 in "5559"; do
		RCW=$SRDS1"_"$SRDS2
		if [ ! -d *$RCW ]; then
			continue;
		fi
		for BOOT in "qspi" "sd"; do
			RCW_INFILE=`realpath *$RCW/*$BOOT*.bin 2> /dev/null`
			if [ "$RCW_INFILE" != "" ] &&  [ -f $RCW_INFILE ]; then
				echo "Pushing $RCW for $BOOT to U-Boot tree"
				$CNV_TOOL $CNV_OPT $RCW_INFILE > $UBOOT_PATH/tqmls1088a_rcw_$BOOT"_"$RCW.cfg
			fi
		done
	done
done
