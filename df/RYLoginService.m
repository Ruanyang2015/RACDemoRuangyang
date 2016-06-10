//
//  RYLoginService.m
//  df
//
//  Created by ruanyangyang on 16/6/10.
//  Copyright © 2016年 ruanyangyang. All rights reserved.
//

#import "RYLoginService.h"

@implementation RYLoginService
-(void)signalWidthName:(NSString *)userName password:(NSString *)passWord hander:(RYLoginServices)hander{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [userName isEqualToString:@"user"] && [passWord isEqualToString:@"password"];
        hander(YES);
    });
}
@end
