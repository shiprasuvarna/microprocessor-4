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
