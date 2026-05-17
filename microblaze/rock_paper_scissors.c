/* Rock-Paper-Scissors: PC Terminal vs FPGA Keypad                            */

#include "PmodKYPD.h"
#include "sleep.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xuartlite_l.h"

#define KEYPAD_BASEADDR XPAR_AXI_GPIO_0_BASEADDR
#define DEFAULT_KEYTABLE "0FED789C456B123A"

PmodKYPD myDevice;

/** Wait for a character from the PC terminal (UART) */
int get_pc_input() {
    xil_printf("PC Player: Enter 1(Rock), 2(Paper), or 3(Scissors)...\r\n");
    
    u8 c = 0;
    while (1) {
        // Wait for a byte to arrive in the UART RX FIFO
        c = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);
        
        // Convert ASCII char to integer
        int val = c - '0'; 
        
        if (val >= 1 && val <= 3) {
            xil_printf("PC selected: %d\r\n", val);
            return val;
        }
    }
}

/* Wait for a key press on the physical Pmod Keypad */
int get_keypad_input() {
    xil_printf("FPGA Player: Press 1, 2, or 3 on Keypad...\r\n");
    
    u16 keystate;
    XStatus status;
    u8 key;
    
    while (1) {
        keystate = KYPD_getKeyStates(&myDevice);
        status = KYPD_getKeyPressed(&myDevice, keystate, &key);
        
        // Only accept if a single key is pressed and it's 1, 2, or 3
        if (status == KYPD_SINGLE_KEY) {
            int val = key - '0';
            if (val >= 1 && val <= 3) {
                xil_printf("FPGA selected: %d\r\n", val);
                
                // Wait for the user to release the key to avoid double-triggers
                while (KYPD_getKeyStates(&myDevice) != 0); 
                
                return val;
            }
        }
        usleep(1000); // Small delay to prevent CPU overheating
    }
}

int main() {

    Xil_ICacheEnable();
    Xil_DCacheEnable();
    
    KYPD_begin(&myDevice, KEYPAD_BASEADDR);
    KYPD_loadKeyTable(&myDevice, (u8*) DEFAULT_KEYTABLE);
    
    
    Xil_Out32(myDevice.GPIO_addr, 0xF); // Set column pins high to prepare for scannings

    xil_printf("--- Rock Paper Scissors Game Started ---\r\n");

    while (1) {
        int pc = get_pc_input();
        int fpga = get_keypad_input();
        int winner = 0; // 1: PC, 2: FPGA, 0: Tie

        if (pc == fpga) {
            xil_printf("It's a tie!\r\n");
        }
        // Logic for FPGA Winning: 
        // (Paper beats Rock) OR (Scissors beats Paper) OR (Rock beats Scissors)
        else if ((fpga == 2 && pc == 1) || (fpga == 3 && pc == 2) || (fpga == 1 && pc == 3)) {
            xil_printf("FPGA won! ");
            winner = 2;
        }
        else {
            xil_printf("PC User won! ");
            winner = 1;
        }

        // Print details if not a tie
        if (winner != 0) {
            if (pc == 1 && fpga == 2) xil_printf("paper(2) > rock(1)\r\n");
            else if (pc == 1 && fpga == 3) xil_printf("rock(1) > scissors(3)\r\n");
            else if (pc == 2 && fpga == 1) xil_printf("paper(2) > rock(1)\r\n");
            else if (pc == 2 && fpga == 3) xil_printf("scissors(3) > paper(2)\r\n");
            else if (pc == 3 && fpga == 1) xil_printf("rock(1) > scissors(3)\r\n");
            else if (pc == 3 && fpga == 2) xil_printf("scissors(3) > paper(2)\r\n");
        }

        xil_printf("--- Next Round ---\r\n\r\n");
        usleep(500000); // Half second pause between rounds
    }

    Xil_DCacheDisable();
    Xil_ICacheDisable();
    return 0;
}