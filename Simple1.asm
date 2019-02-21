#include p18f87k22.inc

	extern  keyboard_columns, keyboard_output, user_input ; external keyboard subroutines
	extern	LCD_Setup, LCD_Write_Message, LCD_Output, counter
	extern	DAC_Setup, DAC_plot, variable1, variable2, voltage
	
acs0	udata_acs   ; reserve data space in access ram
delay_count	res 1   ; reserve one byte for counter in the delay routine
logic_destination   res 1 ; reserve one byte for output of XOR
checker_count	res 1	 ;reserve one byte for checker count
fret_value	res 1	;reserve one byte for fret value

rst	code	0    ; reset vector
	goto	setup
	
main	code
	; ******* Programme FLASH read Setup Code ***********************
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	call	keyboard_columns ; setup for column orientation

	goto    start

;------ CHECKER FUNCTION ---------------------------------------------------
check	
	call	keyboard_output	;puts the value of PORTE into user_input
	movf	user_input, W	
	xorwf	fret_value , 0  ; XOR with fret_value and user input, zero if the same
	movwf	logic_destination   ; stores in the bit logic destination
	tstfsz	logic_destination ; branches out of loop if false
	call	LCD_Output
	decfsz	checker_count ; branches to the top of loop if true
	bra	check
	return
	
;------------delay function------------------------------------------------	
delay	
    decfsz	delay_count	; decrement until zero
    bra check
    return

start
	movlw	0x00
	movwf	voltage
	
	movlw	0xff
	movwf	variable1
	movwf	variable2
	
	call	DAC_Setup

keyboard_test
	call	keyboard_output
	bra	keyboard_test
DAC_loop
	movlw   0x00
	movwf	voltage
	call	DAC_plot
	
	movlw	0x0e
	movwf	voltage
	call	DAC_plot
	
	movlw	0x42 
	movwf	voltage
	call	DAC_plot
	
	movlw	0xb54
	movwf	voltage
	call	DAC_plot
	
	bra	DAC_loop
	
	movlw	0x00		;This checks which frets NEED to be pressed
	movwf	fret_value	;This stores them in memory location
	
	movlw	0x04		;This checks how long the fret needs to be pressed
	movwf	checker_count
	call	check
	end