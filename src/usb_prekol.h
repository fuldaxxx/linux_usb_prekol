#ifndef LINUX_USB_PREKOL_USB_PREKOL_H
#define LINUX_USB_PREKOL_USB_PREKOL_H

#ifdef ARCH_X86_64
    #define EXECVE_SYMBOL "__x64_sys_execve"
#else
    #define EXECVE_SYMBOL "__ia32_sys_execve"
#endif

static int __init usb_prekol_init(void);
static void __exit usb_prekol_exit(void);

#endif //LINUX_USB_PREKOL_USB_PREKOL_H
