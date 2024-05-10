#pragma once

#include <stdint.h>

struct task
{
    uint_fast8_t id;
    uint_fast8_t prior;
};

#define PLATFORM_NR_TASK 64

#if (UINT_FAST8_MAX < PLATFORM_NR_TASK)
    #error "FASTINT_MAX less than PLATFORM_NR_TASK, overflow may occurs"
#endif
