; CMPE12 - Fall 2014
; CONVERTS MORSE TO STRING
; AND STRING TO MORSE
; ONLY WORKS WITH B810B8 AND SOS
; DUE TO TIME CONSTRAINTS

; The code will begin in memory at the address
; specified by .orig <number>.
.ORIG   x3000
START:
; clear all registers that we may use
	AND R0, R0, 0
	AND R1, R0, 0
	AND R2, R0, 0
	AND R3, R0, 0
	AND R4, R0, 0
; print out a greeting
	LEA R0, GREETING
	PUTS
; get a user-entered character (result in R0)
; echo it back right away (otherwise it isn?t visible)
INPUT	GETC
	PUTC

; CHECKS TO SEE IF THE USER WANTS TO DECODE OR ENCODE
; ELSE REDO AND PRINT ERROR MESSEGE
	LD R1, DECODE
	ADD R2, R0, R1
	BRz DECODER
	LD R1, ENCODE
	ADD R2, R0, R1
	BRZ ENCODER
	LEA R0, ILLEGAL
	PUTS
	BRNZP INPUT

; ENCODER
; INSERT STRING INTO X3200+N
; ONLY TAKES IN 30 STRINGS
ENCODER ADD R4, R4, #-15
	ADD R4, R4, #-15
	LEA R0, INSERT
	PUTS
	LD R3, STRING
INP	GETC
	PUTC
	ADD R6, R6, #1
	ADD R5, R4, R6
	BRZ STOP
	STR R0, R3, #0 ; STORE STRING
	ADD R3, R3, #1
	LD R1, ENTER
	ADD R2, R0, R1
	BRNP INP

STOP	LD R4, STRING
BACKUP  LDR R5, R4, 0
	AND R3, R3, 0
	ADD R4, R4, #1
	ADD R6, R6 #-1
	BRN END
	LD R1, NEGS
	ADD R3, R5, R1	
	BRZ SKIPS
	LD R1, NEGO
	ADD R3, R5, R1	
	BRZ SKIPS
	BRNZP END

SKIPO	LEA R0, O	
	PUTS
	BRzp BACKUP
	
SKIPS	LEA R0, S
	PUTS
	BRnzp BACKUP

BRNZP END

; DECODER
; INSERT STRING INTO X3200+N
; ONLY TAKES IN 30 STRINGS
DECODER ADD R4, R4, #-15
	ADD R4, R4, #-15
	LEA R0, INSERT
	PUTS
	LD R3, STRING
INP1	GETC
	PUTC
	ADD R6, R6, #1
	ADD R5, R4, R6
	BRz STOP2
	STR R0, R3, #0
	ADD R3, R3, #1
	LD R1, ENTER
	ADD R2, R0, R1
	BRnp INP1

; Algorithim for converting Two Hex to single byte
; Load variables
STOP2	LD R4, STRING
	LD R2, STORE
GOTO	LD R1, THIRTY 
	LD R7, FORTY
	ADD R6, R6, #-1
	LDR R5, R4, 0
	ADD R5, R5, R7
; DETERMINES IF THE FIRST STRING IS IN A-F OR 0-9
	BRp POS
	BRnz OKAY
POS     LDR R5, R4, 0
	ADD R5, R5, R1
	ADD R5, R5, #-6
	ADD R4, R4, #1
	BRnzp SKIP7
OKAY	LDR R5, R4, 0
	ADD R5, R5, R1    
	ADD R4, R4, #1
SKIP7	LDR R3, R4, 0
	ADD R3, R3, R7
; DETERMINES IF THE SECOND STRING IS IN A-F OR 0-9
	BRp POS2
	BRnz OKAY2
POS2	LDR R3, R4, 0
	ADD R3, R5, R1
	ADD R3, R3, #-6
	ADD R4, R4, #1
	BRnzp SKIP8
OKAY2	LDR R3, R4, 0
	ADD R3, R3, R1
	ADD R4, R4, #1

; SUBTRACT BOTH HEXES AND ADD TO SINGLE BIT R1
; ADD 16 FROM FIRST HEX AND 1 FROM SECOND
; HEX 1 = R5, HEX 2 = R3
SKIP8	AND R1, R1, #0
	ADD R5, R5, #-1
	BRz ADDONE
	BRp FOR
ADDONE	ADD R1, R1, #8
	ADD R1, R1, #8
FOR	ADD R5, R5, #-1
	BRn SKIP3
	ADD R1, R1, #8
	ADD R1, R1, #8
	BRnzp FOR
SKIP3	ADD R3, R3, #-1
	BRn SKIP4
	ADD R1, R1, #1
	BRnzp SKIP3
SKIP4	STR R1, R2, #0
	ADD R2, R2, #1
	ADD R6, R6, #-2
	BRp GOTO

; STORE STRING
	LD R3, STORE
UP	LD R1, LL
	LDR R4, R3 #0
	ADD R2, R4, R1
	BRz SKIPLS
	LD R1, OO
	ADD R2, R4, R1
	BRz SKIPOS
	BRnzp END

; Print string
SKIPLS	LEA R0, LS	
	PUTS
	ADD R3, R3, #1
	BRnzp UP
	
SKIPOS	LEA R0, OS
	PUTS
	ADD R3, R3, #1
	BRnzp UP
	
; stop the processor
END	HALT
; data declarations follow below
; strings
	GREETING: .STRINGZ "Welcome.\nEnter letter: "
	INSERT: .STRINGZ " Insert string: "
	ILLEGAL: .STRINGZ " TRY AGAIN. "
; variables
	THIRTY	.FILL	xFFD0
	FORTY	.FILL	XFFC6
	NEGATIVE .FILL	xFFFF
	STRING:	.FILL	x3201
	STORE:	.FILL	x3221
	USERINPUT: .FILL 0
	ENTER:	.FILL	xFFF6	;-ENTER
	ENCODE: .FILL 	xFFBB	;-x44 = E
	DECODE:	.FILL	xFFBC	;-x43 = D
	LL:	.FILL	xFF48
	OO:	.FILL	xFFF0
	NEGA:	.FILL	xFFBF   
	NEGB:	.FILL	xFFBE
	NEGC:	.FILL	xFFBD
	NEGD:	.FILL	xFFBC
	NEGE:	.FILL	xFFBB
	NEGF:	.FILL	xFFBA
	NEGG:	.FILL	xFFB9
	NEGH:	.FILL	xFFB8
	NEGI:	.FILL	xFFB7
	NEGJ:	.FILL	xFFB6
	NEGK:	.FILL	xFFB5
	NEGL:	.FILL	xFFB4
	NEGM:	.FILL	xFFB3
	NEGN:	.FILL	xFFB2
	NEGO:	.FILL	xFFB1
	NEGP:	.FILL	xFFB0
	NEGQ:	.FILL	xFFAF
	NEGR:	.FILL	xFFAE
	NEGS:	.FILL	xFFAD
	NEGT:	.FILL	xFFAC
	NEGU:	.FILL	xFFAB
	NEGV:	.FILL	xFFAA
	NEGW:	.FILL	xFFA9
	NEGX:	.FILL	xFFA8
	NEGY:	.FILL	xFFA7
	NEGZ:	.FILL	xFFA6
	NEG0:	.FILL	x0000
	NEG1:	.FILL	xFFFF
	NEG2:	.FILL	xFFFE
	NEG3:	.FILL	xFFFD
	NEG4:	.FILL	xFFFC
	NEG5:	.FILL	xFFFB
	NEG6:	.FILL	xFFFA
	NEG7:	.FILL	xFFF9
	NEG8:	.FILL	xFFF8
	NEG9:	.FILL	xFFF7

	A: 	.STRINGZ	"A0"
	B:	.STRINGZ	"78"	
	C:	.STRINGZ	"58"
	D:	.STRINGZ	"70"
	E:	.STRINGZ	"C0"
	F:	.STRINGZ	"D8"
	G: 	.STRINGZ	"30"
	H:	.STRINGZ	"F8"
	I:	.STRINGZ	"E0"
	J:	.STRINGZ	"88"
	K:	.STRINGZ	"50"
	L:	.STRINGZ	"B8"
	M:	.STRINGZ	"20"
	N:	.STRINGZ	"60"
	O:	.STRINGZ	"10"
	P:	.STRINGZ	"98"
	Q:	.STRINGZ	"28"
	R:	.STRINGZ	"B0"
	S:	.STRINGZ	"F0"
	T:	.STRINGZ 	"40"
	U:	.STRINGZ	"D0"
	V:	.STRINGZ	"E8"
	W:	.STRINGZ	"90"
	X:	.STRINGZ	"68"
	Y:	.STRINGZ	"48"
	Z:	.STRINGZ	"38"
	ZERO:	.STRINGZ	"04"
	ONE:	.STRINGZ	"84"
	TWO:	.STRINGZ	"C4"
	THREE:	.STRINGZ	"E4"
	FOUR:	.STRINGZ	"F4"
	FIVE:	.STRINGZ	"FC"
	SIX:	.STRINGZ	"7C"
	SEVEN:	.STRINGZ	"3C"
	EIGHT:	.STRINGZ	"1C"
	NINE:	.STRINGZ	"0C"

	AS: 	.STRINGZ	"A"
;	BS:	.STRINGZ	"B"	
;	CS:	.STRINGZ	"C"
;	DS:	.STRINGZ	"D"
;	ES:	.STRINGZ	"E"
;	FS:	.STRINGZ	"F"
;	GS: 	.STRINGZ	"G"
;	HS:	.STRINGZ	"H"
;	IS:	.STRINGZ	"I"
;	JS:	.STRINGZ	"J"
;	KS:	.STRINGZ	"K"
	LS:	.STRINGZ	"L"
;	MS:	.STRINGZ	"M"
;	NS:	.STRINGZ	"N"
	OS:	.STRINGZ	"O"
;	PS:	.STRINGZ	"P"
;	QS:	.STRINGZ	"Q"
;	RS:	.STRINGZ	"R"
;	SS:	.STRINGZ	"S"
;	TS:	.STRINGZ	"T"
;	US:	.STRINGZ	"U"
;	VS:	.STRINGZ	"V"
;	WS:	.STRINGZ	"W"
;	XS:	.STRINGZ	"X"
;	YS:	.STRINGZ	"Y"
;	ZS:	.STRINGZ	"Z"
;	ZEROS:	.STRINGZ	"0"
;	ONES:	.STRINGZ	"1"
;	TWOS:	.STRINGZ	"2"
;	THREES:	.STRINGZ	"3"
;	FOURS:	.STRINGZ	"4"
;	FIVES:	.STRINGZ	"5"
;	SIXS:	.STRINGZ	"6"
;	SEVENS:	.STRINGZ	"7"
;	EIGHTS:	.STRINGZ	"8"
;	NINES:	.STRINGZ	"9"
	
; end of code
	.END