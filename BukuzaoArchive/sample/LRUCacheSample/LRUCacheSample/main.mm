//
//  main.m
//  LRUCacheSample
//
//  Created by everettjf on 2018/9/27.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "LRUCache.hpp"
#include <string>

using namespace std;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LRUCache<string, int> cache(5);
        cache.insert("a",1);
        cache.insert("b",2);
        cache.insert("c",3);
        cache.insert("d",4);
        cache.insert("e",5);
        
        cache.forEach([](string& key,int& value){
            NSLog(@"%s - %d",key.c_str(),value);
        });
        
        NSLog(@">> after insert 6");
        
        cache.insert("f",6);
        
        cache.forEach([](string& key,int& value){
            NSLog(@"%s - %d",key.c_str(),value);
        });
        
        NSLog(@">> after get d");
        
        cache.get("d");
        
        cache.forEach([](string& key,int& value){
            NSLog(@"%s - %d",key.c_str(),value);
        });
    }
    return 0;
}
