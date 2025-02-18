CURRENT = $(shell uname -r)
ARCH := $(shell uname -m)
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)
DEST = /lib/modules/$(CURRENT)/misc
TARGET = src/usb_prekol
obj-m := $(TARGET).o

ifeq ($(ARCH), x86_64)
	CFLAGS_MODULE := -DARCH_X86_64
	SYMBOL_NAME := "__x64_sys_execve"
else
	CFLAGS_MODULE := -DARCH_X86
	SYMBOL_NAME := "__ia32_sys_execve"
endif

EXTRA_CFLAGS := $(CFLAGS_MODULE)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	@rm -f *.o .*.cmd .*.flags *.mod.c *.order
	@rm -f .*.*.cmd *.symvers *~ *.*~ TODO.*
	@rm -fR .tmp*
	@rm -rf .tmp_versions