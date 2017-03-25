//
//  main.m
//  FBInjectableTest
//
//  Created by everettjf on 16/8/11.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>


int main(int argc, char * argv[]) {
    
    {
        const struct mach_header *mhp = _dyld_get_image_header(0);
        const struct section * sec = getsectbyname("__DATA", "FBInjectable");
        const char * memory = (const char *)( sec->offset + (uint32_t)mhp);
        NSData *d = [NSData dataWithBytes:(const void *)memory length:72];
        NSString *text = [NSString stringWithFormat:@"%@", d];
        NSLog(@"memory text = %@", text);
        
        uint32_t *memory32 = (uint32_t*)memory;
        for(int idx = 0; idx < 72/4; ++idx){
            memory32[idx] += (uint32_t)mhp;
        }
        
        d = [NSData dataWithBytes:(const void *)memory length:72];
        text = [NSString stringWithFormat:@"%@", d];
        NSLog(@"memory text modified = %@", text);
    }
    
    
    {
        
        const struct mach_header *mhp = _dyld_get_image_header(0);
        //    Dl_info dlinfo;
        //    dladdr((const void *)main, &dlinfo);
        //#ifndef __LP64__
        //    const struct mach_header *mhp = (const struct mach_header*)dlinfo.dli_fbase;
        //#else
        //    const struct mach_header_64 *mhp = (const struct mach_header_64*)dlinfo.dli_fbase;
        //#endif
        
        unsigned long size = 0;
        uint8_t *data = getsectiondata(mhp, "__DATA", "FBInjectable", & size);
        NSData *d = [NSData dataWithBytes:(const void *)data length:72];
        
        
        NSString *text = [NSString stringWithFormat:@"%@", d];
        NSLog(@"injectable text = %@", text);
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
    }
    
    @autoreleasepool {
        // memory read -c72 data
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
