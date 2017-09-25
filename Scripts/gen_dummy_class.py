




def main():
    print '#import <Foundation/Foundation.h>'

    for i in range(0,100000):
        print '@interface Hello%d : NSObject'%i
        print '@end'
        print '@implementation Hello%d'%i
        print '-(void)say%d:(NSString *)str{'%i
        print 'NSLog(@"say:%@",str);}'
        print '@end'


if __name__ == '__main__':
    main()
