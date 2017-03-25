//
//  main.m
//  AttributeTest
//
//  Created by everettjf on 16/8/15.
//  Copyright © 2016年 everettjf. All rights reserved.
//
#import <Foundation/Foundation.h>


#include <unistd.h>
#include <stdint.h>
#include <stdio.h>

// Functions
typedef void (*myown_call)(void);

static void mspec1(void)
{
    write(1, "aha!\n", 5);
}

static void mspec2(void)
{
    write(1, "aloha!\n", 7);
}

static void mspec3(void)
{
    write(1, "hello!\n", 7);
}


static myown_call mc1  __attribute__((used, section("__DATA,myfunctions"))) = mspec1;
static myown_call mc2  __attribute__((used, section("__DATA,myfunctions"))) = mspec2;
static myown_call mc3  __attribute__((used, section("__DATA,myfunctions"))) = mspec3;

// const strings
char * kString1 __attribute((unused, section("__DATA,FBInjectable"))) = "string 1";
char * kString2 __attribute((unused, section("__DATA,FBInjectable"))) = "string 2";
char * kString3 __attribute((unused, section("__DATA,FBInjectable"))) = "string 3";

void call_functions_in_section(void)
{
    myown_call *call_ptr = &mc1;
    {
        fprintf (stderr, "call_ptr: %p\n", call_ptr);
        (*call_ptr)();
    }
    
    call_ptr = &mc2;
    {
        fprintf (stderr, "call_ptr: %p\n", call_ptr);
        (*call_ptr)();
    }
    
    call_ptr = &mc3;
    {
        fprintf (stderr, "call_ptr: %p\n", call_ptr);
        (*call_ptr)();
    }
    
    printf("size &mc1 : %lu\n", sizeof(&mc1));
    printf("size mc1 : %lu\n", sizeof(mc1));
    printf("size const string : %lu\n", sizeof(kString1));
}

int main(int argc, const char * argv[]) {
    call_functions_in_section();
    
    @autoreleasepool {
        NSLog(@"string 1 = %s", kString1);
        NSLog(@"string 2 = %s", kString2);
        NSLog(@"string 3 = %s", kString3);
        
    }
    return 0;
}
