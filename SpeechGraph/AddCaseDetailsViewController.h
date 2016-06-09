//
//  AddCaseDetailsViewController.h
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-26.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseDetailsViewController.h"

@interface AddCaseDetailsViewController : UIViewController <UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UITextField *dataXTextField;
@property (strong, nonatomic) IBOutlet UITextField *dataYTextField;
@property (strong, nonatomic) IBOutlet UITextField *dataZTextField;
@property (strong, nonatomic) IBOutlet UIButton *addDataButton;

@property (weak, nonatomic) CaseDetailsViewController *caseDetailsViewController;


@property (strong, nonatomic) NSNumber *caseNumber;

- (IBAction)addDataButtonClicked:(id)sender;

@end
