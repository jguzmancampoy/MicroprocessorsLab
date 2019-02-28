#include p18f87k22.inc

	extern  keyboard_columns, keyboard_output, user_input ; external keyboard subroutines
	extern	LCD_Setup, LCD_Write_Message, LCD_Output_GO, counter, LCD_Clear, LCD_Output_L1,LCD_Output_L2
	extern	DAC_Setup, DAC_plot, voltage
	extern	fret_values, voltages
	extern  fret1,fret2,fret3,fret4,fret_zero
	
	
acs0	udata_acs		; reserve data space in access ram
delay_count	    res	    1   ; reserve one byte for counter in the delay routine
logic_destination   res	    1	; reserve one byte for output of XOR
checker_count	    res	    1	; reserve one byte for checker count
fret_value	    res	    1	; reserve one byte for fret value
DCounter1	    res	    1	; ""
DCounter2	    res	    1	; ""
DCounter3	    res	    1	; ""
AA		    res	    1
BB		    res	    1
CC		    res	    1
d1		    res	    1
d2		    res	    1
d3		    res	    1	    


rst	code	0    ; reset vector
	goto	setup
	
main	code
	; ******* Programme FLASH read Setup Code ***********************
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	call	keyboard_columns ; setup for column orientation
	call	fret_values
	call	voltages
	call	LCD_Setup
	goto    start

;------ CHECKER FUNCTION ---------------------------------------------------
checking	
	call	keyboard_output	;puts the value of PORTE into user_input
	movf	user_input, W
	xorwf	fret_value , 0  ; XOR with fret_value and user input, zero if the same
	movwf	logic_destination   ; stores in the bit logic destination
	tstfsz	logic_destination ; branches out of loop if false
	call	LCD_Output_GO
	return
	
;------------delay function------------------------------------------------		
check
	movlw	0x11
    	movwf	DCounter1
	movlw	0x5D
	movwf	DCounter2
	movlw	0x05
	movwf	DCounter3
	
check_loop
	call	checking
	call	keyboard_output	    ;calls the keyboard plotter in the delay
	decfsz	DCounter1, f	    
	goto	check_loop
	decfsz	DCounter2, f
	goto	check_loop
	decfsz	DCounter3, f
	goto	check_loop
	return


delay	
	movlw	0x11
	movwf	d1
	movlw	0x5D
	movwf	d2
	movlw	0x05
	movwf	d3
	
Delay_loop
	call	keyboard_output	    ;calls the keyboard plotter in the delay
	decfsz	d1, f
	goto	Delay_loop
	decfsz	d2, f
	goto	Delay_loop
	decfsz	d3, f
	goto	Delay_loop
	return	

level0
	movlw	0xff ;
	movwf   voltage
	return
level1
	movlw	0xdc
	movwf   voltage
	return
level2
	movlw	0x99
	movwf   voltage
	return
level3
	movlw	0x7e
	movwf   voltage
	return
level4
	movlw	0x4f;
	movwf   voltage
	return
	
start	
	call	DAC_Setup
	call	song1
	call	fret_values

	
song1
	call	delay  
	call	delay
	call	delay
	call	delay
	call	delay  
	call	delay  
	call	delay
	call	delay
	call	delay  
	call	delay
	call	delay
	call	delay
	
	
	call	LCD_Output_L1
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level2
	call	DAC_plot
	call	delay
	call	delay
	movff	fret2, fret_value
	call	check
	
	call	level3
	call	DAC_plot
	call	delay
	call	delay
	movff	fret3, fret_value
	call	check
	
	call	level4
	call	DAC_plot
	call	delay
	call	delay
	movff	fret4, fret_value
	call	check

	call	level3
	call	DAC_plot
	call	delay
	call	delay
	movff	fret3, fret_value
	call	check
	
	call	level2
	call	DAC_plot
	call	delay
	call	delay
	movff	fret2, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level4
	call	DAC_plot
	call	delay
	call	delay
	movff	fret4, fret_value
	call	check
	
	call	LCD_Output_L2
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level2
	call	DAC_plot
	call	delay
	call	delay
	movff	fret2, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret2, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check
	
	call	level4
	call	DAC_plot
	call	delay
	call	delay
	movff	fret4, fret_value
	call	check
	
	call	level3
	call	DAC_plot
	call	delay
	call	delay
	movff	fret3, fret_value
	call	check
	
	call	level2
	call	DAC_plot
	call	delay
	call	delay
	movff	fret2, fret_value
	call	check
	
	call	level1
	call	DAC_plot
	call	delay
	call	delay
	movff	fret1, fret_value
	call	check
	
	call	level0
	call	DAC_plot
	call	delay
	call	delay
	movff	fret_zero, fret_value
	call	check

	end
	