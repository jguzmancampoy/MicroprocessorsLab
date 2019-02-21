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
;	movlw	b'10000111'	; Set timer0 to 16-bit, Fosc/4/256
;	movwf	T0CON		; = 62.5KHz clock rate, approx 1sec rollover
	
;	bsf	INTCON,TMR0IE	; Enable timer0 interrupt
;	bsf	INTCON,GIE	; Enable all interrupts
	return
DELAY
	movlw	0xbd
    	movwf	DCounter1
	movlw	0x4b
	movwf	DCounter2
	movlw	0x15
	movwf	DCounter3
    
LOOP
	decfsz	DCounter1, 1
	goto	LOOP
	decfsz	DCounter2, 1
	goto	LOOP
	decfsz	DCounter3, 1
	goto	LOOP
	return
	
DAC_plot
	movff	voltage, PORTJ
	call	DELAY
	return
;DAC_plot_user
	;movff 

	end


