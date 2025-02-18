CURRENT = $(shell uname -r)
ARCH := $(shell uname -m)
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)
DEST = /lib/modules/$(CURRENT)/misc
TARGET = src/usb_prekol
obj-m := $(TARGET).o
MODULE_NAME := usb_prekol

ifeq ($(ARCH), x86_64)
	CFLAGS_MODULE := -DARCH_X86_64
	SYMBOL_NAME := "__x64_sys_execve"
else
	CFLAGS_MODULE := -DARCH_X86
	SYMBOL_NAME := "__ia32_sys_execve"
endif

TARGET_PROCESS ?= "phpstorm"

EXTRA_CFLAGS := $(CFLAGS_MODULE) -DTARGET_PROCESS=\"$(TARGET_PROCESS)\"

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	@rm -f *.o .*.cmd .*.flags *.mod.c *.order
	@rm -f .*.*.cmd *.symvers *~ *.*~ TODO.* *.module-common.o
	@rm -fR .tmp*
	@rm -rf .tmp_versions
	@rm -f .module-common.o
	@rm -f Module.symvers modules.order
	@rm -f $(TARGET).ko
	@rm -f $(TARGET).o
	@rm -f $(TARGET).mod
	@rm -f $(TARGET).mod.c
	@rm -f $(TARGET).mod.o
	@rm -f $(TARGET).*.cmd
	@rm -f $(TARGET).o.cmd
	@rm -f src/.$(MODULE_NAME).ko.cmd
	@rm -f src/.$(MODULE_NAME).mod.cmd
	@rm -f src/.$(MODULE_NAME).mod.o.cmd
	@rm -f src/.$(MODULE_NAME).o.cmd


load: default
	sudo insmod $(TARGET).ko

unload:
	sudo rmmod $(MODULE_NAME)

install: default
	sudo cp $(TARGET).ko /lib/modules/$(CURRENT)/kernel/drivers/usb/
	sudo depmod
	echo "usb_prekol" | sudo tee /etc/modules-load.d/usb_prekol.conf > /dev/null
	echo "options usb_prekol TARGET_PROCESS=$(TARGET_PROCESS)" | sudo tee /etc/modprobe.d/usb_prekol.conf > /dev/null
	sudo modprobe usb_prekol

uninstall:
	sudo rm -f /lib/modules/$(CURRENT)/kernel/drivers/usb/$(TARGET).ko
	sudo rm -f /etc/modules-load.d/usb_prekol.conf
	sudo rm -f /etc/modprobe.d/usb_prekol.conf
	sudo depmod
	sudo modprobe -r usb_prekol