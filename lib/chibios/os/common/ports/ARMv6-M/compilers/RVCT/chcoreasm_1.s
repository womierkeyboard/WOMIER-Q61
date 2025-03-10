
;#if !defined(FALSE) || defined(__DOXYGEN__)
;#define FALSE   0
;#endif

;#if !defined(TRUE) || defined(__DOXYGEN__)
;#define TRUE    1
;#endif

;#define _FROM_ASM_
;#include "chlicense.h"
;#include "chconf.h"
;#include "chcore.h"

;#if !defined(__DOXYGEN__)

;;/*
;; * RTOS-specific context offset.
;; */
;#if defined(_CHIBIOS_RT_CONF_)
;#define CONTEXT_OFFSET  12

;#elif defined(_CHIBIOS_NIL_CONF_)
;#define CONTEXT_OFFSET  0

;#else
;#error "invalid chconf.h"
;#endif

SCB_ICSR        EQU     0xE000ED04

                PRESERVE8
                THUMB
                AREA    |.text|, CODE, READONLY

                IMPORT  chThdExit
                IMPORT  chSchDoPreemption
;#if CH_DBG_STATISTICS
;                IMPORT  __stats_start_measure_crit_thd
;                IMPORT  __stats_stop_measure_crit_thd
;#endif
;#if CH_DBG_SYSTEM_STATE_CHECK
;                IMPORT  __dbg_check_unlock
;                IMPORT  __dbg_check_lock
;#endif

;/*
; * Performs a context switch between two threads.
; */
                EXPORT  __port_switch
__port_switch   PROC
                push    {r4, r5, r6, r7, lr}
                mov     r4, r8
                mov     r5, r9
                mov     r6, r10
                mov     r7, r11
                push    {r4, r5, r6, r7}
                mov     r3, sp
;                str     r3, [r1, #CONTEXT_OFFSET]
;                ldr     r3, [r0, #CONTEXT_OFFSET]  
                str     r3, [r1, #12]
                ldr     r3, [r0, #12]
                mov     sp, r3
                pop     {r4, r5, r6, r7}
                mov     r8, r4
                mov     r9, r5
                mov     r10, r6
                mov     r11, r7
                pop     {r4, r5, r6, r7, pc}
                ENDP

;/*
; * Start a thread by invoking its work function.
; * If the work function returns @p chThdExit() is automatically invoked.
; */
                EXPORT  __port_thread_start
__port_thread_start PROC
;#if CH_DBG_SYSTEM_STATE_CHECK
;                bl      __dbg_check_unlock
;#endif
;#if CH_DBG_STATISTICS
;                bl      __stats_stop_measure_crit_thd
;#endif
                cpsie   i
                mov     r0, r5
                blx     r4
                movs    r0, #0              ;/* MSG_OK */
                bl      chThdExit
zombies         b       zombies
                ENDP

;/*
; * Post-IRQ switch code.
; * Exception handlers return here for context switching.
; */
                EXPORT  __port_switch_from_isr
                EXPORT  __port_exit_from_isr
__port_switch_from_isr PROC
;#if CH_DBG_STATISTICS
;                bl      __stats_start_measure_crit_thd
;#endif
;#if CH_DBG_SYSTEM_STATE_CHECK
;                bl      __dbg_check_lock
;#endif
                bl      chSchDoPreemption
;#if CH_DBG_SYSTEM_STATE_CHECK
;                bl      __dbg_check_unlock
;#endif
;#if CH_DBG_STATISTICS
;                bl      __stats_stop_measure_crit_thd
;#endif
__port_exit_from_isr
                ldr     r2, =SCB_ICSR
                movs    r3, #128
;#if CORTEX_ALTERNATE_SWITCH
;                lsls    r3, r3, #21
;                str     r3, [r2, #0]
;                cpsie   i
;#else
                lsls    r3, r3, #24
                str     r3, [r2, #0]
;#endif
waithere        b       waithere
                ENDP

                END

;#endif /* !defined(__DOXYGEN__) */
