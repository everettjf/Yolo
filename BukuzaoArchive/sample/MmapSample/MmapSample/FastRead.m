//
//  FastRead.m
//  MmapSample
//
//  Created by everettjf on 2018/8/26.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "FastRead.h"
#import <UIKit/UIKit.h>
#include <unistd.h>
#include <mach/mach.h>
#include <sys/mman.h>
#include <sys/utsname.h>

@implementation FastRead

+ (void)run
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSLog(@"%@",[NSString stringWithUTF8String:systemInfo.machine]);
    NSLog(@"%@",[UIDevice currentDevice].systemVersion);
    NSLog(@"%@GB",@([NSProcessInfo processInfo].physicalMemory / 1024.0/ 1024.0/1024.0));
    
    long sz = sysconf(_SC_PAGESIZE);
    NSLog(@"sc page size = %ld bytes (%ld kb)",sz,sz/1024);

    int pagesize = getpagesize();
    NSLog(@"get page size = %d bytes (%d kb)",pagesize,pagesize/1024);

    vm_size_t vmpagesize = 0;
    host_page_size(mach_host_self(), &vmpagesize);
    NSLog(@"host page size = %lu bytes (%lu kb)",vmpagesize,vmpagesize/1024);
    
    vm_size_t vmkern = vm_kernel_page_size;
    NSLog(@"vm kern page size = %lu bytes (%lu kb)",vmkern,vmkern/1024);
    
//    NSLog(@"page mask = %lu bytes (%u kb)",PAGE_MASK,PAGE_MASK/1024);
    NSLog(@"page size = %lu bytes (%u kb)",PAGE_SIZE,PAGE_SIZE/1024);
    
}

@end
