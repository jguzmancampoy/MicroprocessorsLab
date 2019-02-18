#include p18f87k22.inc
	
	global	DAC_Setup, DAC_plot, variable1, variable2, voltage
	
	
acs0		udata_acs	    ; reserve data space in access ram
variable1	res	1   ;reserve space for delay
variable2	res	1   ;reserve space for delay
voltage		res	1   ; reserve byte for voltage		
	
	
	
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
;	movlw	b'10000111'	; Set timer0 to 16-bit, Fosc/4/256
;	movwf	T0CON		; = 62.5KHz clock rate, approx 1sec rollover
	
;	bsf	INTCON,TMR0IE	; Enable timer0 interrupt
;	bsf	INTCON,GIE	; Enable all interrupts
	return

DAC_plot
;DAC_plot_delay	
;	decfsz  variable1
;	goto	DAC_plot_delay
	incf	voltage
	movff	voltage, PORTJ
	
;	decfsz  variable2
;	goto	DAC_plot	return
	
	end


