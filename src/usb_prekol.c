#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/kprobes.h>
#include <linux/string.h>
#include <linux/fs.h>
#include "usb_prekol.h"

static int handle_process(struct kprobe *p, struct pt_regs *regs)
{
    struct task_struct *task = current;

    if (strcmp(task->comm, TARGET_PROCESS) == 0) {
        disable_all_usb();
    }

    return 0;
}

static struct kprobe kp = {
    .symbol_name = EXECVE_SYMBOL,
    .pre_handler = handle_process,
};

static int __init usb_prekol_init(void)
{
    int ret;

    ret = register_kprobe(&kp);
    if (ret < 0) {
        printk(KERN_INFO "Failed to register kprobe, error %d\n", ret);
        return ret;
    }

    printk(KERN_INFO "USB PREKOL module loaded\n");
    return 0;
}

static void __exit usb_prekol_exit(void)
{
    unregister_kprobe(&kp);
    printk(KERN_INFO "USB PREKOL module unloaded\n");
}

module_init(usb_prekol_init);
module_exit(usb_prekol_exit);

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("Ruslan Gorbunov <ruslangorbunovv@gmail.com>");