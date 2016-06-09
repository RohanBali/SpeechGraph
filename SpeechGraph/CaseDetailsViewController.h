//
//  CaseDetailsViewController.h
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-26.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRD3DBarChart/FRD3DBarChartViewController.h"

@interface CaseDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,FRD3DBarChartViewControllerDelegate> {
}

@property (nonatomic,strong) NSDictionary *caseDictionary;
@property (nonatomic,strong) NSArray *caseDetailsArray;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@property (strong, nonatomic) IBOutlet UIButton *graphDataButton;


- (void)setupCaseDetails;

- (IBAction)graphDataButtonClicked:(id)sender;

@end
