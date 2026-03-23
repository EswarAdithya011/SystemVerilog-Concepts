#include <stdio.h>
#include <svdpi.h>

// "I don't know where this is, but SV promised to provide it."
extern void sv_log_call(int a, int b, int op);

int alu_model(int a, int b, int opcode) {
    // Calling back to SV 
    sv_log_call(a, b, opcode);
  
    switch(opcode) {
        case 0: return a + b;
        case 1: return a - b;
        case 2: return a * b;
        case 3: return b != 0 ? a / b : 0;
        case 4: return b != 0 ? a % b : 0;
        default: return 0;
    }
}
