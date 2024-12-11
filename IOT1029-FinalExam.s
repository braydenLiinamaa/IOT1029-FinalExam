.global _start
_start:
    	LDR r0, =array       	@ r0 points to the start of the array
    	LDR r1, =length 	@ sets r1 to the array length
    	LDR r2, =target       	@ sets r2 to the integer to be removed
    	LDR r3, [r1]          	@ sets r3 to the array length
    	MOV r4, r0            	@ r4 is the output pointer

loop:
    	CMP r3, #0            	@ Ends if the amount of remaining elements is 0
    	BEQ end
	LDRB r5, [r0], #1     	@ Load next element into r5 and increment r0
    	CMP r5, r2            	@ Compare element with the target
	BEQ skip              	@ If it's the target, skip copying
	STRB r5, [r4], #1     	@ If it's not the target, store it in the output location and increment r4

skip:
	SUB r3, r3, #1        	@ subtracts from the remaining elements count
	BAL loop

end:
	SUB r4, r4, r0        	@ r4 - r0 = new size of array
	LDR r1, =0x1000       	@ Store the updated size in memory
 	STR r4, [r1]       	@ Store the updated size in memory
	MOV R3, #11
