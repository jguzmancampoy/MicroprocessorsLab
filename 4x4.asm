#include p18f87k22.inc

    global  keyboard_columns, keyboard_output, user_input

acs0	udata_acs
user_input 	res 1

keyboard    code

keyboard_columns
    banksel PADCFG1
    bsf	    PADCFG1, REPU, BANKED
    clrf    LATE
    movlw   0x0f
    movwf   TRISE
    return
	
keyboard_output
    movlw	0x00
    movwf	TRISD
    movff	PORTE, user_input ; goto current line in code
    movff	user_input, PORTD
    return
    
    end

