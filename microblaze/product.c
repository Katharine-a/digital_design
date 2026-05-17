#include "xil_printf.h"
#include "xgpio.h"
#include <unistd.h>
#include <string.h>

int main(){
	char buf[64];
	XGpio gpio;
	u32 led;

	XGpio_Initialize(&gpio, 0);

	XGpio_SetDataDirection(&gpio, 2, 0x00000000); // set LED GPIO channel tristates to All Output


	for(;;){
		int a = 0;
		int b = 0;
		int i = 0;
		
		/* Prompt the user */
		xil_printf("\n Please enter a number of the format # * # \n");

		/* Read User Input */
		ssize_t n = read(0, buf, sizeof(buf) - 1);

		if (n > 0){
			buf[n] = '\0';
		} else {
			return 0;
		}

		while (i < n && buf[i] != '*') {
			if (buf[i] >= '0' && buf[i] <= '9') {
				a = a * 10 + (buf[i] - '0');
			}
			i++;
		}

		if (i < n && buf[i] == '*') {
			i++;
		}

		while (i < n && buf[i] != '\0') {
			if (buf[i] >= '0' && buf[i] <= '9') {
				b = b * 10 + (buf[i] - '0');
			}
			i++;
		}

		int product = a * b;
		xil_printf("Product: %d ", product);

		if (product > 100){
			xil_printf("Product exceeds 100");
			led = 0xFFFFFFFF;
		}else{
			led = 0x00000000;
		}

		XGpio_DiscreteWrite(&gpio, 2, led);
	}
}
