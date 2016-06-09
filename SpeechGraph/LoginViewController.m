//
//  ViewController.m
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-18.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor whiteColor];
    self.usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButtonClicked:(id)sender {
    [[RequestManager sharedInstance] requestLoginWithUserName:[self.usernameTextField text]
                                                     Password:[self.passwordTextField text]
                                                      success:^(NSString *username, NSString *userID) {
                                                          
                                                          NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                                                          [f setNumberStyle:NSNumberFormatterDecimalStyle];
                                                          NSNumber * myNumber = [f numberFromString:userID];
                                                          
                                                          [self.mainViewController setUserName:username];
                                                          [self.mainViewController setUserNumber:myNumber];
                                                          [self.mainViewController setupLoggedInUser];
                                                          
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      } failure:^{
                                                        
                                                      }];
}

#pragma mark - UITextFieldDelegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
