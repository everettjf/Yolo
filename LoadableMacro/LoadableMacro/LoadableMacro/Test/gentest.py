import os


first = """
#import <Foundation/Foundation.h>
#import "QWLoadable.h"
"""


def genfile(filename,prefix,loadcount):
    f = open(filename,'w')
    f.write(first)

    for c in range(loadcount):
        body = """
@interface FooObject : NSObject
@end
@implementation FooObject
+ (void)userDefinedLoad{
    NSLog(@"FooObject");
}
@end

QWLoadableFunctionBegin(FooObject)
[FooObject userDefinedLoad];
QWLoadableFunctionEnd(FooObject)

        """
        body = body.replace('FooObject', 'FooObject%s%d'%(prefix,c))
        f.write(body)


if __name__ == '__main__':
    for c in range(10):
        genfile(
            'TestLoad%d.m'%(c),
            'tag%d'%(c),
            10
        )




