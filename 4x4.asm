#include p18f87k22.inc

    global  keyboard_columns, keyboard_output, user_input, fret_values, voltages

acs0		udata_acs
user_input 	res	1
xor_output	res	1
	
voltage1	res	1	;0xfc	
voltage2	res	1	;0xbd   	
voltage3	res	1	;0x7E	
voltage4	res	1	;0x3f	
voltage_zero	res	1	;0x00
fret_zero	res	1	;0x0f
fret1		res	1	;0x0e
fret2		res	1	;0x0d
fret3		res	1	;0x0b
fret4		res	1	;0x07
	
	
	
keyboard    code

keyboard_columns
	banksel	    PADCFG1
	bsf	    PADCFG1, REPU, BANKED
	clrf	    LATE
	movlw	    0x0f
	movwf	    TRISE
	return
	
fret_values
	movlw	    0x0e
	movwf	    fret1
	movlw	    0x0d
	movwf	    fret2
	movlw	    0x0b
	movwf	    fret3
	movlw	    0x07
	movwf	    fret4
	movlw	    0x0f
	movwf	    fret_zero
voltages
	movlw	    0xDC    
	movwf	    voltage1
	movlw	    0x99   
	movwf	    voltage2
	movlw	    0x7e
	movwf	    voltage3
	movlw	    0x4f   
	movwf	    voltage4
	movlw	    0xff
	movwf	    voltage_zero
	
keyboard_output
	movlw	    0x0e
	movwf	    fret1
	movlw	    0x00
	movwf	    TRISD
	movff	    PORTE, user_input ; goto current line in code
	movf	    user_input, W
	xorwf	    fret1 ,	0
	movwf	    xor_output
	tstfsz	    xor_output
	bra	    fret2_label
	movff	    voltage1, PORTD
	return
fret2_label
	movlw	    0x0d
	movwf	    fret2
	movf	    user_input, W
	xorwf	    fret2   ,	0
	movwf	    xor_output
	tstfsz	    xor_output
	bra	    fret3_label
	movff	    voltage2, PORTD
	return
fret3_label
	movlw	    0x0b
	movwf	    fret3
	movf	    user_input, W
	xorwf	    fret3   ,	0
	movwf	    xor_output
	tstfsz	    xor_output
	bra	    fret4_label
	movff	    voltage3, PORTD
	return
fret4_label
	movlw	    0x07
	movwf	    fret4
	movf	    user_input, W
	xorwf	    fret4  , 0
	movwf	    xor_output
	tstfsz	    xor_output
	bra	    no_fret
	movff	    voltage4, PORTD
	return
no_fret
	movlw	    0x0f
	movwf	    fret_zero
	movf	    user_input, W
	xorwf	    fret_zero  , 0
	movwf	    xor_output
	tstfsz	    xor_output
	nop
	movff	    voltage_zero, PORTD
	return
    end

