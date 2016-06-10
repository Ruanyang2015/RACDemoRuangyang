//
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"
#import <ReactiveCocoa/ReactiveCocoa.h> 
#import "UIView+Extension.h"
@interface RWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;
 @property (nonatomic, weak) UIButton *mybtn;
//@property (nonatomic) BOOL passwordIsValid;
//@property (nonatomic) BOOL usernameIsValid;
@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    UIButton *mybtn=[[UIButton alloc] init];
  [self updateUIState];
    [mybtn setBackgroundImage:[UIImage imageNamed:@"btndisAble"] forState:UIControlStateDisabled];
    [mybtn setTitle:@"登陆" forState:UIControlStateNormal];
    [mybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mybtn setBackgroundImage:[UIImage imageNamed:@"createxunjian"] forState:UIControlStateNormal];
    mybtn.width=200;
    mybtn.height=36;
    mybtn.center=self.view.center;
    mybtn.y=self.passwordTextField.y+80;
    self.mybtn=mybtn;
    [self.view addSubview:self.mybtn];
  self.signInService = [RWDummySignInService new];
  
  // handle text changes for both text fields
//  [self.usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
//  [self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
  
  // initially hide the failure message
  self.signInFailureText.hidden = YES;
//
//    [self.usernameTextField.rac_textSignal subscribeNext:^(id x){
//        NSLog(@"%@", x);
//    }];
    
//    RACSignal *usernameSourceSignal =
//    self.usernameTextField.rac_textSignal;
//    
//    RACSignal *filteredUsername =[usernameSourceSignal
//                                  filter:^BOOL(id value){
//                                      NSString*text = value;
////                                      NSLog(@"%@",text);
//                                     
//                                          return text.length >= 3;
//                                  }];
////    RACSignal *filterNameSignal=[usernameSourceSignal fi];
//    
//    [filteredUsername subscribeNext:^(id x){
//        NSLog(@"%@", x);
//        self.usernameIsValid=YES;
//    }];
    
    
    
//    [[[self.usernameTextField.rac_textSignal
//       map:^id(NSString*text){
//           return @(text.length);
//       }]
//      filter:^BOOL(NSNumber*length){
//          return[length integerValue] > 3;
//      }]
//     subscribeNext:^(id x){
//         NSLog(@"%@", x);
//     }];
    
    
    RACSignal *validUsernameSignal =
    [self.usernameTextField.rac_textSignal
     map:^id(NSString *text) {
         self.signInFailureText.hidden =YES;
         return @([self isValidUsername:text]);
     }];
    
    
    RACSignal *validPasswordSignal =
    [self.passwordTextField.rac_textSignal
     map:^id(NSString *text) {
         self.signInFailureText.hidden =YES;
         NSLog(@"输入的值是:%@",text);
         return @([self isValidPassword:text]);
     }];
    
    /** 下面有更好的写法:*/
//    [[validPasswordSignal
//      map:^id(NSNumber *passwordValid){
//          return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
//      }]
//     subscribeNext:^(UIColor *color){
//         self.passwordTextField.backgroundColor = color;
//     }];
//    /** RAC宏允许直接把信号的输出应用到对象的属性上。RAC宏有两个参数，第一个是需要设置属性值的对象，第二个是属性名。每次信号产生一个next事件，传递过来的值都会应用到该属性上。*/
//    
//    RAC(self.passwordTextField, backgroundColor) =
//    [validPasswordSignal
//     map:^id(NSNumber *passwordValid){
//         return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
//     }];
//    
//    RAC(self.usernameTextField, backgroundColor) =
//    [validUsernameSignal
//     map:^id(NSNumber *passwordValid){
//         return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
//     }];
////
//    RACSignal *signUpActiveSignal =
//    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
//                      reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
//                          return @([usernameValid boolValue]&&[passwordValid boolValue]);
//                      }];
//    
//    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
//        self.mybtn.enabled =[signupActive boolValue];
//    }];
    
//  [[self.mybtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {//然后添加了一个订阅，在每次事件发生时都会输出log。
////        self.mybtn.enabled=NO;
//        NSLog(@"登陆按钮点击了");
//        [self signInSignal];
//    } ];
    
//    [[self.mybtn rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
//        return [self signInSignal];
//    }];


    /** 当然这里返回的并不是登陆信号*/
    
//    [[[self.mybtn rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {//这里你返回 nil 也好但就是不要返回 void
//       return [self signInSignal];
//    }] subscribeNext:^(id x) {
//        NSLog(@"Sign in result: %@", x);
//
//    }];
    
    
//    * 现在添加登陆调转逻辑:
    [[[self.mybtn rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
        self.mybtn.enabled=NO;
        return [self signInSignal];
    }] subscribeNext:^(NSNumber* signin) {
        BOOL signStatues=[signin boolValue];
        self.signInFailureText.hidden = signStatues;
        if (signStatues) {
            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
        }
    }];
    
    [[[[self.mybtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        self.mybtn.enabled =NO;
        self.signInFailureText.hidden =YES;
    }]
     flattenMap:^RACStream *(id value) {
         return [self signInSignal];
     }]
     subscribeNext:^(NSNumber* signin) {
                 BOOL signStatues=[signin boolValue];
                 self.signInFailureText.hidden = signStatues;
                 if (signStatues) {
                     [self performSegueWithIdentifier:@"signInSuccess" sender:self];
                 }
             }
     ];
}
/** 
 创建信号
 幸运的是，把已有的异步API用信号的方式来表示相当简单。首先把RWViewController.m中的signInButtonTouched:删掉。你会用响应式的的方法来替换这段逻辑。
 */

- (RACSignal *)signInSignal {
    [self.view endEditing:YES];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
        [self.signInService
         signInWithUsername:self.usernameTextField.text
         password:self.passwordTextField.text
         complete:^(BOOL success){
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}
/** 上面的代码使用RACSignal的createSignal:方法来创建信号。方法的入参是一个block，这个block描述了这个信号。当这个信号有subscriber时，block里的代码就会执行。
 
 
 block的入参是一个subscriber实例，它遵循RACSubscriber协议，协议里有一些方法来产生事件，你可以发送任意数量的next事件，或者用error\complete事件来终止。本例中，信号发送了一个next事件来表示登录是否成功，随后是一个complete事件。
 
 
 这个block的返回值是一个RACDisposable对象，它允许你在一个订阅被取消时执行一些清理工作。当前的信号不需要执行清理操作，所以返回nil就可以了。
 */


- (BOOL)isValidUsername:(NSString *)username {
  return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
  return password.length > 3;
}

- (IBAction)signInButtonTouched:(id)sender {
  // disable all UI controls
  self.signInButton.enabled = NO;
  self.signInFailureText.hidden = YES;
  
  // sign in
  [self.signInService signInWithUsername:self.usernameTextField.text
                            password:self.passwordTextField.text
                            complete:^(BOOL success) {
                              self.signInButton.enabled = YES;
                              self.signInFailureText.hidden = success;
                              if (success) {
                                [self performSegueWithIdentifier:@"signInSuccess" sender:self];
                              }
                            }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// updates the enabled state and style of the text fields based on whether the current username
// and password combo is valid
- (void)updateUIState {
    self.signInButton.enabled=NO;
//  self.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//  self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//  self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
}

- (void)usernameTextFieldChanged {
//  self.usernameIsValid = [self isValidUsername:self.usernameTextField.text];
  [self updateUIState];
}

- (void)passwordTextFieldChanged {
//  self.passwordIsValid = [self isValidPassword:self.passwordTextField.text];
  [self updateUIState];
}

@end
