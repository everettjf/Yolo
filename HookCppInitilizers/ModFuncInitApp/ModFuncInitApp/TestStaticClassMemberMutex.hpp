//
//  TestStaticClassMemberMutex.hpp
//  ModFuncInitApp
//
//  Created by everettjf on 2017/3/20.
//  Copyright © 2017年 everettjf. All rights reserved.
//

#ifndef TestStaticClassMemberMutex_hpp
#define TestStaticClassMemberMutex_hpp

#include <thread>

class TestStaticClassMemberMutex{
public:
    
    void hello();
    
private:
    static std::mutex s_mutex;
};

#endif /* TestStaticClassMemberMutex_hpp */
