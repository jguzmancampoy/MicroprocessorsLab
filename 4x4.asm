#include p18f87k22.inc

    global  keyboard_columns, OUTPUT_D, register_test

acs0	udata_acs
register_test	res 1

keyboard    code

keyboard_columns
    banksel PADCFG1
    bsf	    PADCFG1, REPU, BANKED
    clrf    LATE
    movlw   0x0f
    movwf   TRISE
    
	
OUTPUT_D
	movlw	0x00
	movwf	TRISD
	movff	PORTE, register_test ; goto current line in code
	movff	register_test, PORTD
	return
    
    end

