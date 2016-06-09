//
//  AddCasesViewController.h
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-26.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AddCasesViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) NSNumber *userNumber;

@property (strong, nonatomic) IBOutlet UITextField *casenameTextField;
@property (strong, nonatomic) IBOutlet UITextField *dataXTextField;
@property (strong, nonatomic) IBOutlet UITextField *dataYTextField;
@property (strong, nonatomic) IBOutlet UITextField *dataZTextField;
@property (strong, nonatomic) IBOutlet UIButton *addDataButton;
@property (weak, nonatomic) MainViewController *mainViewController;


- (IBAction)addDataButtonClicked:(id)sender;


@end
