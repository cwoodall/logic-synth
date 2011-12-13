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

/* This file is designed for use with ISim build 0x1cce1bb2 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//ad/eng/users/t/n/tnadov/Xilinx/piano/volume_TEST.v";
static unsigned int ng1[] = {8192U, 0U};
static unsigned int ng2[] = {7U, 0U};
static int ng3[] = {100, 0};
static unsigned int ng4[] = {4096U, 0U};



static void Initial_41_0(char *t0)
{
    char t15[8];
    char *t1;
    char *t2;
    char *t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    int t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t16;

LAB0:    t1 = (t0 + 2528U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(41, ng0);

LAB4:    xsi_set_current_line(43, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1448);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 14);
    xsi_set_current_line(44, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 3);
    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2336);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(48, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 4372);
    *((int *)t8) = t7;

LAB6:    t9 = (t0 + 4372);
    if (*((int *)t9) > 0)
        goto LAB7;

LAB8:    goto LAB1;

LAB7:    xsi_set_current_line(48, ng0);

LAB9:    xsi_set_current_line(49, ng0);
    t10 = (t0 + 2336);
    xsi_process_wait(t10, 10000LL);
    *((char **)t1) = &&LAB10;
    goto LAB1;

LAB10:    xsi_set_current_line(49, ng0);
    t11 = (t0 + 1448);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = ((char*)((ng4)));
    memset(t15, 0, 8);
    xsi_vlog_unsigned_add(t15, 14, t13, 14, t14, 14);
    t16 = (t0 + 1448);
    xsi_vlogvar_assign_value(t16, t15, 0, 0, 14);
    t2 = (t0 + 4372);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB6;

}


extern void work_m_00000000000438353882_2349337151_init()
{
	static char *pe[] = {(void *)Initial_41_0};
	xsi_register_didat("work_m_00000000000438353882_2349337151", "isim/volume_TEST_isim_beh.exe.sim/work/m_00000000000438353882_2349337151.didat");
	xsi_register_executes(pe);
}
