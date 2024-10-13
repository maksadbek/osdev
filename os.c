#include <stdint.h>

#define UART 0x10000000
#define UART_THR (uint8_t*)(UART+0x00)

__attribute__ ((aligned (16))) char stack0[4096 * 1];

void start(void) {
	*UART_THR = 'H';

	return;
}
