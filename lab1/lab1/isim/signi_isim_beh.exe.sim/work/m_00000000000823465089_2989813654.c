/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/TEMP.CS152A-01.000/Desktop/project/lab1/signi.v";
static int ng1[] = {1, 0};



static void Always_31_0(char *t0)
{
    char t6[8];
    char t24[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t25;

LAB0:    t1 = (t0 + 3008U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 3328);
    *((int *)t2) = 1;
    t3 = (t0 + 3040);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);

LAB5:    xsi_set_current_line(32, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t6 + 4);
    t7 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 11);
    t10 = (t9 & 1);
    *((unsigned int *)t6) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 11);
    t13 = (t12 & 1);
    *((unsigned int *)t4) = t13;
    t14 = (t0 + 1768);
    xsi_vlogvar_assign_value(t14, t6, 0, 0, 1);
    xsi_set_current_line(33, ng0);
    t2 = (t0 + 1768);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 1928);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 12);

LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(34, ng0);
    t7 = (t0 + 1048U);
    t14 = *((char **)t7);
    memset(t6, 0, 8);
    t7 = (t6 + 4);
    t15 = (t14 + 4);
    t13 = *((unsigned int *)t14);
    t16 = (~(t13));
    *((unsigned int *)t6) = t16;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t21 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t21 & 4294967295U);
    t22 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t22 & 4294967295U);
    t23 = ((char*)((ng1)));
    memset(t24, 0, 8);
    xsi_vlog_unsigned_add(t24, 32, t6, 32, t23, 32);
    t25 = (t0 + 1928);
    xsi_vlogvar_assign_value(t25, t24, 0, 0, 12);
    goto LAB8;

LAB10:    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t15);
    *((unsigned int *)t6) = (t17 | t18);
    t19 = *((unsigned int *)t7);
    t20 = *((unsigned int *)t15);
    *((unsigned int *)t7) = (t19 | t20);
    goto LAB9;

}


extern void work_m_00000000000823465089_2989813654_init()
{
	static char *pe[] = {(void *)Always_31_0};
	xsi_register_didat("work_m_00000000000823465089_2989813654", "isim/signi_isim_beh.exe.sim/work/m_00000000000823465089_2989813654.didat");
	xsi_register_executes(pe);
}
