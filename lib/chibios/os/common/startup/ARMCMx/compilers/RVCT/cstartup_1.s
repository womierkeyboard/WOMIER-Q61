
main_stack_size EQU     0x00000400

proc_stack_size EQU     0x00000400

heap_size       EQU     0x00000400

                AREA    MSTACK, NOINIT, READWRITE, ALIGN=3
main_stack_mem  SPACE   main_stack_size
                EXPORT  __initial_msp
__initial_msp

                AREA    CSTACK, NOINIT, READWRITE, ALIGN=3
__main_thread_stack_base__
                EXPORT  __main_thread_stack_base__
__main_thread_stack_end__
                EXPORT  __main_thread_stack_end__
proc_stack_mem  SPACE   proc_stack_size
                EXPORT  __initial_sp
__initial_sp

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   heap_size
__heap_limit

CONTROL_MODE_PRIVILEGED     EQU     0
CONTROL_MODE_UNPRIVILEGED   EQU     1
CONTROL_USE_MSP             EQU     0
CONTROL_USE_PSP             EQU     2

                PRESERVE8
                THUMB

                AREA    |.text|, CODE, READONLY



                IMPORT  __main
                EXPORT  Reset_Handler
Reset_Handler   PROC
                cpsid   i
                ldr     r0, =__initial_sp
                msr     PSP, r0
                movs    r0, #CONTROL_MODE_PRIVILEGED :OR: CONTROL_USE_PSP
                msr     CONTROL, r0
                isb
                bl      __early_init

                IF      {TARGET_FPU_SOFTVFP} == {FALSE}
                LDR     R0, =0xE000ED88           ; Enable CP10,CP11
                LDR     R1, [R0]
                ORR     R1, R1, #(0xF << 20)
                STR     R1, [R0]
                ENDIF

                ldr     r0, =__main
                bx      r0
                ENDP

__early_init    PROC
                EXPORT  __early_init            [WEAK]
                bx      lr
                ENDP

                ALIGN


                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap
                ldr     r0, =Heap_Mem
                ldr     r1, =(proc_stack_mem + proc_stack_size)
                ldr     r2, =(Heap_Mem + heap_size)
                ldr     r3, =proc_stack_mem
                bx      lr

                ALIGN

                ENDIF

                END

