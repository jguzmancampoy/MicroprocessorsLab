#include p18f87k22.inc

	extern  keyboard_columns, OUTPUT_D, register_test ; external keyboard subroutines
	
acs0	udata_acs   ; reserve data space in access ram
counter	    res 1   ; reserve one byte for a counter variable
delay_count res 1   ; reserve one byte for counter in the delay routine
logic_destination   res 1 ; reserve one byte for output of XOR

rst	code	0    ; reset vector
	goto	setup
	
main	code
	; ******* Programme FLASH read Setup Code ***********************
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	
	movlw	0x0e
	movwf	0x44
check	
	call	OUTPUT_D
	movlw	register_test	
	XORWF	0x44 , 0
	movwf	logic_destination
	;check for loc44 check xand
	;branch to check for time given by loc 50
	

	; a delay subroutine if you need one, times around loop in delay_count
 delay	decfsz	delay_count	; decrement until zero
	bra delay
	return

	end