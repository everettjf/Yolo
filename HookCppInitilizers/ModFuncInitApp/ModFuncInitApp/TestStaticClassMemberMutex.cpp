//
//  TestStaticClassMemberMutex.cpp
//  ModFuncInitApp
//
//  Created by everettjf on 2017/3/20.
//  Copyright © 2017年 everettjf. All rights reserved.
//

#include "TestStaticClassMemberMutex.hpp"


std::mutex TestStaticClassMemberMutex::s_mutex;


void TestStaticClassMemberMutex::hello(){
    s_mutex.lock();
    
    s_mutex.unlock();
}
