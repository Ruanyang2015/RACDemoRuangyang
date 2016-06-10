//
//  RYLoginViewVC.m
//  df
//
//  Created by ruanyangyang on 16/6/10.
//  Copyright © 2016年 ruanyangyang. All rights reserved.
//

#import "RYLoginViewVC.h"
#import "RWDummySignInService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
@interface RYLoginViewVC ()
@property (weak, nonatomic) IBOutlet UIView *usernametag;
@property (weak, nonatomic) IBOutlet UIView *userpwdTag;
@property (weak, nonatomic) IBOutlet UITextField *userNameFtd;
@property (weak, nonatomic) IBOutlet UITextField *userPedFtd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(id)sender;
@property (strong, nonatomic) RWDummySignInService *signInService;
@end

@implementation RYLoginViewVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"RAC Login";
    self.userPedFtd.backgroundColor=[UIColor lightGrayColor];
    RACSignal *userNameSignal=[self.userNameFtd.rac_textSignal map:^id(NSString *text) {
//        NSLog(@"用户名输入的数据流是:%@",text);
        return @([self checkuserNameStatues:text]);
    }];
    
    RACSignal *userPwdSignal=[self.userPedFtd.rac_textSignal map:^id(NSString *text) {
//        NSLog(@"用户密码输入的数据流是:%@",text);
        return @([self checkPwdStatues:text]);
    }];
//    [userPwdSignal subscribeNext:^(id x) {
////        NSLog(@"用户密码输入的数据流是:%@",x);
//    }];
    
    //单个判断密码是否符合规则
//    [self cheackMima:userPwdSignal];
    
    //两个条件判断
    [self checkPWdAndNAMe:userPwdSignal name:userNameSignal];
    
    //登陆按钮处理
    [self disoveLoginBtn];
    
    [[[self.loginBtn
       rac_signalForControlEvents:UIControlEventTouchUpInside]
      flattenMap:^id(id x){
          return[self signInSignals];
      }]
     subscribeNext:^(id x){
         NSLog(@"Sign in result: %@", x);
     }];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 登陆按钮处理:
-(void)disoveLoginBtn{
//    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchDown] flattenMap:^RACStream *(id value) {
//        return [self signInSignal];
//    }] subscribeNext:^(NSNumber* signin) {
//        BOOL signStatues=[signin boolValue];
////        self.signInFailureText.hidden = signStatues;
//        if (signStatues) {
////            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//            [UIAlertView bk_showAlertViewWithTitle:@"登陆成功" message:@"欢迎光临" cancelButtonTitle:@"" otherButtonTitles:@[@""] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//                
//            }];
//        }else{
//            NSLog(@"登陆失败");
//        }
//    }];
    
//    [[[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
////        self.loginBtn.enabled =NO;
////        self.signInFailureText.hidden =YES;
//        
//    }] flattenMap:^RACStream *(id value) {
//        return [self signInSignal];
//    }] subscribeNext:^(NSNumber* signin) {
//        BOOL signStatues=[signin boolValue];
////        self.signInFailureText.hidden = signStatues;
//        
//        if (signStatues) {
////            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//            NSLog(@"恭喜你登陆成功");
//        }else{
//            NSLog(@"登陆失败");
//        }
//    }];
    
//    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
////        self.loginBtn.enabled=NO;
//        return [self signInSignal];
//    }] subscribeNext:^(NSNumber* signin) {
//        BOOL signStatues=[signin boolValue];
////        self.signInFailureText.hidden = signStatues;
//        if (signStatues) {
//            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//        }
//    }];
//    
//    
//    [[[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
////        self.loginBtn.enabled =NO;
////        self.signInFailureText.hidden =YES;
//    }]
//      flattenMap:^RACStream *(id value) {
//          return [self signInSignal];
//      }]
//     subscribeNext:^(NSNumber* signin) {
//         BOOL signStatues=[signin boolValue];
////         self.signInFailureText.hidden = signStatues;
//         if (signStatues) {
//             [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//             NSLog(@"登陆成功");
//         }
//     }
//     ];

}

- (RACSignal *)signInSignals {
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        BOOL sss=[self signInWithUsername:self.userPedFtd.text
         password:self.userNameFtd.text
         complete:^(BOOL success){

         }];
        [subscriber sendNext:@(sss)];
        [subscriber sendCompleted];
        return nil;
    }];

}

- (BOOL)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock {
 
    BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"password"];
    return success;
}
-(void)checkNAme:(RACSignal *)name{
    [[name map:^id(NSNumber *value) {
        return [value boolValue]?[UIColor greenColor]:[UIColor grayColor];
    }] subscribeNext:^(UIColor *color) {
        self.usernametag.backgroundColor=color;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)cheackMima:(RACSignal *)validPasswordSignal{
    
    
    
    
    
    
    [[validPasswordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue]?[UIColor greenColor]:[UIColor grayColor];
    }]
     subscribeNext:^(UIColor *color) {
         self.userpwdTag.backgroundColor=color;
         
     }];
    
    
}

-(BOOL )checkuserNameStatues:(NSString *)text{
    return text.length>3;
}

-(void)checkPWdAndNAMe:(RACSignal *)pwdSignal name:(RACSignal *)name{
     [self cheackMima:pwdSignal];
    [self checkNAme:name];
    
    
    [[RACSignal combineLatest:@[pwdSignal,name] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue]&&[passwordValid boolValue]);
    }]
     subscribeNext:^(NSNumber*signupActive) {
         self.loginBtn.enabled =[signupActive boolValue];
     }];
    
    
}

-(BOOL )checkPwdStatues:(NSString *)text{
    return text.length>3;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(id)sender {
    
}
@end
