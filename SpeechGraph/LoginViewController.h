//
//  ViewController.h
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-18.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) MainViewController *mainViewController;

- (IBAction)loginButtonClicked:(id)sender;

@end

