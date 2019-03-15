; Solar Tracker
; By Jack Ellison and Michael Georgariou
; For CPE 233 with Dr. Paul Hummel.
;
; Uses photoresistor inputs to change speeds to servo OUTPUT.
; Four photoresistor inputs total, two per input (each 4 bits)
; Outputs two numbers between 0 - 250, representing positioning
; of servos.

.EQU LIGHTINPUT1 = 0x30       ; represents two photoresistors
.EQU LIGHTINPUT2 = 0x31       ; represents two photoresistors
.EQU SERVO1 = 0x42            ; output for servo on roll axis
.EQU SERVO2 = 0x43            ; output for servo on pitch axis

.CSEG                         ; code section begins
.ORG 0x01                     ; starts at spot 1 on program counter

MOV R20, 0x7D                 ; initializes servo 1 output at 125 (halfway)
MOV R21, 0x7D                 ; initializes servo 2 output at 125 (halfway)

GETINPUTS:                    ; starting branch
IN R0, LIGHTINPUT1            ; gets first input, stores in R0
MOV R1, R0                       ; stores R0 in R1
MOV R2, R0                       ; and in R2
AND R1, 0x0F                  ; hide bottom four bits on R1
AND R2, 0xF0                  ; hide top four bits on R2

IN R3, LIGHTINPUT2            ; gets second input, stores in R3
MOV R4, R3                    ; stores R3 in R4
MOV R5, R3                    ; and in R5
AND R4, 0x0F                  ; hide bottom four bits on R4
AND R5, 0xF0                  ; hide top four bits on R5

CLC                           ; clears the carry as a precaution
LSR R2                        ; shifts R2's bits down four times
LSR R2
LSR R2
LSR R2
CLC                           ; again clears carry as precaution
LSR R5                        ; shifts R5's bits down four times
LSR R5
LSR R5
LSR R5                       
CLC                           ; one last clear for good measure

CALL CMPINPUT1                ; go to branch to do work on the first input
CALL CMPINPUT2                ; do work on second axis

OUTPUT:
OUT R20, SERVO1               ; outputs value for first servo
OUT R21, SERVO2               ; outputs value for second servo

BRN GETINPUTS                 ; and start over


CMPINPUT1:
CMP R1, R2                    ; compares two sensors for first axis
BREQ EQUAL                    ; if R1 = R2, don't adjust numbers, do axis 2
BRCC SUBTRACT1                ; if R1 > R2, subtract 1 from axis's output
BRCS ADDIT1                   ; if R1 < R2, add 1 to axis's output

CMPINPUT2:
CMP R4, R5                    ; compares two sensors for second axis
BREQ EQUAL                    ; if R4 = R5, don't adjust numbers, output
BRCC SUBTRACT2                ; if R4 > R5, subtract 1 from axis's output
BRCS ADDIT2                   ; if R4 < R5, add 1 to axis's output

EQUAL:                        ; if it's equal, or to avoid over/underflow
RET                           ; just return

SUBTRACT1:
CMP R20, 0x00                 ; if number is already zero don't underflow
BREQ EQUAL                    ; just move on to axis 2
SUB R20, 0x01                 ; otherwise, move first axis in direction 1
RET                           ; and THEN move on to axis 2

SUBTRACT2:
CMP R21, 0x00                 ; see comments on SUBTRACT1.
BREQ EQUAL
SUB R21, 0x01
RET

ADDIT1:
CMP R20, 0xFA                 ; if the number is already 250, don't overflow
BRCC EQUAL                    ; just move on to axis 2
ADD R20, 0x01                 ; otherwise, move first axis in direction 2
RET                           ; and THEN move on to axis 2

ADDIT2:
CMP R21, 0xFA                 ; see comments on ADDIT1
BRCC EQUAL
ADD R21, 0x01
RET
