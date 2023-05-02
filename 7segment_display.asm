; Seven Segment Display Interfacing
.model small
.stack 100h

.data
    ; Define the segment patterns for digits 0-9
    segmentPatterns db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.code
    ; Entry point of the program
    main proc
        mov ax, @data
        mov ds, ax

        ; Set up the ports for data and control signals
        mov dx, 0x378    ; Data port
        mov ax, 0xFF01   ; Control port

        ; Initialize the display
        out dx, al

        mov cx, 10       ; Number of iterations (0-9)
        mov si, offset segmentPatterns  ; Start of segment patterns

    displayLoop:
        mov al, [si]    ; Load the segment pattern for the current digit
        out dx, al      ; Output the pattern to the data port

        ; Delay for a short period to display the segment
        mov cx, 1000    ; Delay loop count
    delayLoop:
        loop delayLoop

        ; Increment to the next digit
        inc si

        ; Check if we have displayed all digits
        loop displayLoop

        mov ax, 4C00h   ; Exit the program
        int 21h

    main endp
end main

_____________________________________________
;Interfacing 7 segment display
DATA SEGMENT
PORTA EQU 00H 
PORTB EQU 02H
PORTC EQU 04H
PORT_CON EQU 06H
DATA ENDS
CODE SEGMENT
MOV AX, DATA
MOV DS,AX
ORG 100H
MOV DX, PORT_CON
MOV AL, 10000010B
MOV AL, 11000000B 
MOV DX, PORTA
OUT DX,AL
START:
MOV DX, PORTB
IN AL, DX
MOV DX, PORTA 
CMP AL, 11111110B 
JZ S0
CMP AL, 11111101B 
JZ S1
CMP AL, 11111011B 
JZ S2
CMP AL, 11110111B 
JZ S3
CMP AL, 11101111B 
JZ S4
CMP AL, 11011111B 
JZ S5
CMP AL, 10111111B 
JZ S6
CMP AL, 01111111B 
JZ S7
JMP START 
DISPLAY:
OUT DX,AL 
JMP START
S0:
MOV AL, 11000000B 
JMP DISPLAY
S1:
MOV AL, 11111001B 
JMP DISPLAY
S2:
MOV AL, 10100100B 
JMP DISPLAY
S3:
MOV AL, 10110000B 
JMP DISPLAY
S4:
MOV AL, 10011001B 
JMP DISPLAY
S5:
MOV AL, 10010010B 
JMP DISPLAY
S6:
MOV AL, 10000010B 
JMP DISPLAY
S7:
MOV AL, 11111000B 
JMP DISPLAY
CODE ENDS 
END

_____________________________________________
