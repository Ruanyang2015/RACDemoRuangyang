//
//  RYLoginService.h
//  df
//
//  Created by ruanyangyang on 16/6/10.
//  Copyright © 2016年 ruanyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RYLoginServices) (BOOL);
@interface RYLoginService : NSObject
-(void)signalWidthName:(NSString *)userName password:(NSString *)passWord hander:(RYLoginServices)hander;
//- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock;
@end
