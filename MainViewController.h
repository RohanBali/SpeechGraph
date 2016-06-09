//
//  MainViewController.h
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-22.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_casesArray;
}

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *userNumber;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@property (strong, nonatomic) IBOutlet UIButton *addCasesButton;

- (IBAction)addCasesButtonClicked:(id)sender;

- (void)setupLoggedInUser;

@end
