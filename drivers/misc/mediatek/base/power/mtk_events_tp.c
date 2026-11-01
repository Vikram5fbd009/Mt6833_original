// SPDX-License-Identifier: GPL-2.0
/*
 * Tracepoint provider for MTK events (PPM, SWPM, etc.)
 *
 * The __tracepoint_* structs referenced by:
 *   - drivers/misc/mediatek/base/power/ppm_v3/src/mtk_ppm_main.c
 *       (__tracepoint_ppm_user_setting, __tracepoint_ppm_update, ...)
 *   - drivers/misc/mediatek/base/power/swpm_v1/mt6833/mtk_swpm_platform.c
 *       (__tracepoint_swpm_power)
 *   ...are defined here.
 *
 * Without CREATE_TRACE_POINTS + include, only the extern declarations
 * exist (declared by TRACE_EVENT in the header), and the linker fails
 * with "undefined symbol: __tracepoint_*".
 *
 * Both tracepoints we currently need live in include/trace/events/mtk_events.h.
 */
#include <linux/module.h>

#define CREATE_TRACE_POINTS
#include <trace/events/mtk_events.h>
