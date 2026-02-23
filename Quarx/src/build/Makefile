ASM=nasm

SRC_DIR=src
BUILD_DIR=build

.PHONY: all drive_image kernel bootloader clean always

#
# Drive Image
#
drive_image: $(BUILD_DIR)/main_drive.img

$(BUILD_DIR)/main_drive.img: bootloader kernel
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_drive.img
	truncate -s 1440k $(BUILD_DIR)/main_drive.img

#
# Bootloader
#
bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: always
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/bootloader.bin

#
# Kernel
#
kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

#
# Always
#
always:
	mkdir -p $(BUILD_DIR)


#
# Clean
#
clean:
	rm -rf $(BUILD_DIR)/*


