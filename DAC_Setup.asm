#include p18f87k22.inc
	
	global	DAC_Setup, DAC_plot, variable1, variable2, voltage
	
	
acs0		udata_acs	    ; reserve data space in access ram
variable1	res	1   ;reserve space for delay
variable2	res	1   ;reserve space for delay
voltage		res	1   ; reserve byte for voltage		

DCounter1	equ	0X0C
DCounter2	equ	0X0D
DCounter3	equ	0X0E
	
	
int_hi	code	0x0008		; high vector, no low vector
	btfss	INTCON,TMR0IF	; check that this is timer0 interrupt
	retfie	FAST		; if not then return
	incf	LATB		; increment PORTD
	bcf	INTCON,TMR0IF	; clear interrupt flag
	retfie	FAST		; fast return from interrupt

DAC	code
DAC_Setup
	clrf	TRISJ		; Set PORTD as all outputs
	clrf	LATJ		; Clear PORTD outputs
	return
DAC_plot
	movff	voltage, PORTJ
	return

	end


