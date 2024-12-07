CC = riscv64-unknown-elf-gcc
CFLAGS = -g -nostdlib -fno-builtin -mcmodel=medany -march=rv64g

QEMU = qemu-system-riscv64
QFLAGS = -nographic -smp 1 -machine virt -bios none

OBJDUMP = riscv64-unknown-elf-objdump

all: os.elf

os.elf: start.S
	$(CC) $(CFLAGS) -T os.ld -o os.elf $^

qemu: $(TARGET)
	@qemu-system-riscv64 -M ? | grep virt >/dev/null || exit
	@echo "Press Ctrl-A and then X to exit QEMU"
	$(QEMU) $(QFLAGS) -kernel os.elf

qemu-debug: $(TARGET)
	@qemu-system-riscv64 -M ? | grep virt >/dev/null || exit
	@echo "Press Ctrl-A and then X to exit QEMU"
	$(QEMU) $(QFLAGS) -kernel os.elf -s -S

clean:
	rm -f *.elf
	rm -f *.o
