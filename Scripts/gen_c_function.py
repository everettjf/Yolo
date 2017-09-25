




def main():
    print '#import <Foundation/Foundation.h>'

    for i in range(0,100000):
        print 'void foo%d(int param){'%i
        print 'NSLog(@"say:%@",@(param));'
        print '}'


if __name__ == '__main__':
    main()
