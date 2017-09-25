




def main():
    print '#import <Foundation/Foundation.h>'

    for i in range(0,10000):
        print 'void foo%d(int param){'%i
        print 'NSLog(@"say:%@",@(param));'
        print '}'


if __name__ == '__main__':
    main()
