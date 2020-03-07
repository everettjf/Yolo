//
//  redirect_stdout.c
//  PrintfRedirectDemo
//
//  Created by everettjf on 2020/3/3.
//  Copyright © 2020 dsfdsafd. All rights reserved.
//

#include "redirect_stdout.h"
#include <stdlib.h>
#include <stdio.h>

static print_cbk_t gPrintFunc;

static int stdout_redirect(void* prefix, const char* buffer, int size)
{
    if (gPrintFunc)
        gPrintFunc(buffer, size);
    return size;
}

void set_redirect_output(print_cbk_t f)
{
    gPrintFunc = f;

    setvbuf(stdout, 0, _IOLBF, 0); // stdout: line-buffered
    setvbuf(stderr, 0, _IONBF, 0); // stderr: unbuffered

    stdout->_write = stdout_redirect;
    stderr->_write = stdout_redirect;
}



