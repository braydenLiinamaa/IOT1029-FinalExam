.global _start
_start:
    LDR r0, =array         @ r0 points to the start of the array
    LDR r1, =length        @ r1 points to the array length
    LDR r2, =target        @ r2 points to the target integer to remove
    LDR r3, [r1]           @ r3 is the number of elements in the array
    MOV r4, r0             @ r4 is the output pointer (start of the modified array)
    MOV r6, #0             @ r6 is the new size of the array

loop:
    CMP r3, #0             @ Checks if elements remaining is 0
    BEQ end                @ Exits loop if elements remaining is 0
    LDRB r5, [r0], #1      @ Loads the next element into r5 and increments r0
    CMP r5, r2             @ Compares the element with the target
    BEQ skip               @ Skips copying to the new array if it's the target
    STRB r5, [r4], #1      @ Copies the element to the new array and increment r4
    ADD r6, r6, #1         @ Increment the new size counter

skip:
    SUB r3, r3, #1         @ Subract 1 from the remaining elements counter
    B loop                 @ Repeat the loop

end:
    LDR r1, =0x1000        @ Memory location for the updated size
    STR r6, [r1]           @ Store the size of the array in memory
    BX lr
