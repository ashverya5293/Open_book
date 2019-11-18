     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ;IMPORT printMsg
	 ;IMPORT printMsg2p
	 IMPORT printMsg4p
     ENTRY 
__main  FUNCTION 
		MOV R7,#1;
		
		VLDR.F32 S20,=100  ; Enter the radius r value in number of pixels(should be < 320)
		VLDR.F32 S23,=320 ; y offset
		VLDR.F32 S24,=240 ; x offset
		
outer_loop	MOV R0,#0;
			MOV R1,#0;
			CMP R7,#360;
			BLT loop ;
			B stop ;
		
loop		VMOV.F32 S19,R7;
		VCVT.F32.U32 S19,S19;
		
		VLDR.F32 S16, =3.14159265359 ; storing the value of Pi. 
		VLDR.F32 S17, =180 ; 
		VDIV.F32 S18,S16,S17 ; calculating Pi/180
		VMUL.F32 S1,S18,S19 ; Angle is converted into radian
		
		MOV R10,#1; temp variable to store intermediate result
		MOV R11,#2; temp variable to calculate factorial
		MOV R9,#3;  temp variable to calculate factorial
		VLDR.F32 S0,=0;
		VLDR.F32 S11, =1;
		VMUL.F32 S2,S1,S1;
		
		;BL calc_sine  ; Calling sine subroutine
		

sine	VDIV.F32 S1,S1,S11; 
		VADD.F32 S0,S0,S1;  calculating the value of sin x
		
		VMUL.F32 S1,S2,S1;  Series calculation
		MUL R10,R11,R9;  Factorial calculation
		ADD R11,R11,#2; incrementing the factorial variable by 2
		ADD R9,R9,#2;  incrementing the factorial variable by 2
		
		VNEG.F32 S1,S1;  Negate the value of register S1
		VMOV.F32 S11, R10;  Moving the content of register R10 to S11
		VCVT.F32.U32 S11,S11; Converting floating point to unsigned decimal
		ADD R1,R1,#1;  incrementing the counter
		CMP R1,#10;  Comparing the counter value
		BNE sine 
		
		;BX lr
		VLDR.F32 S21,=1;
		VMUL.F32 S21,S20,S0;  Calculating Y co-ordinate
		VADD.F32 S21,S21,S23;
		
		VCVT.S32.F32 S21,S21
		
		VMOV.F32 R0,S21;  Converting floating point to integer value
		;BL printMsg
		
		
		
		MOV R12, #3;  
		MOV R6, #4;
		VLDR.F32 S5, =1;
		VMOV.F32 S15, S2;
		VNEG.F32 S15,S15; Creating x^2 term
		VMOV.F32 S6,S15;
		VLDR.F32 S11, =2;
		MOV R1,#0;
		
		;BL calc_cosine  ; Calling cosine subroutine.
				
calc_cosine	VDIV.F32 S6,S6,S11;  Computing cosx term
		VADD.F32 S5,S5,S6;  Cos series calculation
		VMUL.F32 S6,S6,S2;  Calculating temp variable
		MUL R10,R12,R6;  
		VMOV.F32 S11, R10;
		VCVT.F32.U32 S11,S11;
		VNEG.F32 S6,S6;   Converting to negative number
		ADD R12,R12,#2;
		ADD R6,R6,#2;
		ADD R1,R1,#1; incrementing the counter
		CMP R1,#10;   Comparing the value of counter variable with n
		BNE calc_cosine
		;BX lr
		VLDR.F32 S22,=1;
		VMUL.F32 S22,S20,S5;  Calculating X co-ordinate
		VADD.F32 S22,S22,S24;
			
		VCVT.S32.F32 S22,S22
		
		VMOV.F32 R1,S22;  Converting floating point to integer value
		MOV R2,#100  ; Enter radius value
		;BL printMsg
		;BL printMsg2p
		
		ADD R7,R7,#1 ;
		BL printMsg4p
		
		B outer_loop
		

stop    B stop ; stop program
	ENDFUNC
	END
