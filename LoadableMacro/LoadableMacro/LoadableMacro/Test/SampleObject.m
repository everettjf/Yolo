//
//  SampleObject.m
//  LoadableMacro
//
//  Created by everettjf on 2017/1/4.
//  Copyright © 2017年 everettjf. All rights reserved.
//

#import "SampleObject.h"

@implementation SampleObject

@end

typedef int (*QWLoadableFunctionCallback)(const char *);
typedef void (*QWLoadableFunctionTemplate)(QWLoadableFunctionCallback);

static void QWLoadableSampleFunction(QWLoadableFunctionCallback QWLoadableCallback){
    if(0 != QWLoadableCallback("SampleObject")) return;

    // Do something
}

static QWLoadableFunctionTemplate varSampleObject __attribute((used, section("__DATA,QWLoadable"))) = QWLoadableSampleFunction;


//typedef void (*QWLoadableFunctionTemplate)();
//static void QWLoadableSampleFunction(){
//    // Do something
//}
//static QWLoadableFunctionTemplate varSampleObject __attribute((used, section("__DATA,QWLoadable"))) = QWLoadableSampleFunction;
