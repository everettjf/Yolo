//
//  redirect_stdout.h
//  PrintfRedirectDemo
//
//  Created by everettjf on 2020/3/3.
//  Copyright © 2020 dsfdsafd. All rights reserved.
//

#ifndef redirect_stdout_h
#define redirect_stdout_h

typedef void (*print_cbk_t)(const char* buff, int len);
void set_redirect_output(print_cbk_t f);


#endif /* redirect_stdout_h */
