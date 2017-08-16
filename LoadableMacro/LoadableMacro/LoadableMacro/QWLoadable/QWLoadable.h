//
//  QWLoadable.h
//  LoadableMacroCore
//
//  Created by everettjf on 16/10/8.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#ifndef QWLoadableHeader_h
#define QWLoadableHeader_h

#define QWLoadableSegmentName "__DATA"
#define QWLoadableSectionName "QWLoadable"

#define QWLoadable __attribute((used, section(QWLoadableSegmentName "," QWLoadableSectionName )))

typedef int (*QWLoadableFunctionCallback)(const char *);
typedef void (*QWLoadableFunctionTemplate)(QWLoadableFunctionCallback);

#define QWLoadableFunctionBegin(functionName) \
static void QWLoadable##functionName(QWLoadableFunctionCallback QWLoadableCallback){ \
    if(0 != QWLoadableCallback(#functionName)) return;

#define QWLoadableFunctionEnd(functionName) \
} \
static QWLoadableFunctionTemplate varQWLoadable##functionName QWLoadable = QWLoadable##functionName;

#endif /* QWLoadableHeader_h */
