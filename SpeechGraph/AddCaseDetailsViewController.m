//
//  AddCaseDetailsViewController.m
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-26.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import "AddCaseDetailsViewController.h"
#import "RequestManager.h"

@implementation AddCaseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Methods

- (void)setupBarButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeButtonPressed:)];
}

#pragma mark - Button Methods

- (void)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addDataButtonClicked:(id)sender {
    if ([self.dataXTextField text] && [self.dataYTextField text] && [self.dataZTextField text]) {
        [self requestAddCaseDetails];
    }
}


#pragma mark - Request Methods

- (void)requestAddCaseDetails {
    [[RequestManager sharedInstance] requestAddCaseDetailsWithCaseNumber:self.caseNumber
                                                                   dataX:[self.dataXTextField text]
                                                                   dataY:[self.dataYTextField text]
                                                                   dataZ:[self.dataZTextField text]
                                                                 success:^{
                                                                     [(CaseDetailsViewController*)self.caseDetailsViewController setupCaseDetails];
                                                                     
                                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Added Case"
                                                                                                                     message:@"Added User"
                                                                                                                    delegate:nil
                                                                                                           cancelButtonTitle:@"OK"
                                                                                                           otherButtonTitles: nil];
                                                                     [alert setDelegate:self];
                                                                     [alert show];
                                                                     
                                                                     
                                                                 } failure:^{
                                                                     [(CaseDetailsViewController*)self.caseDetailsViewController setupCaseDetails];
                                                                     
                                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Case created but adding data failed"
                                                                                                                     message:@"Case created but adding data failed"
                                                                                                                    delegate:nil
                                                                                                           cancelButtonTitle:@"OK"
                                                                                                           otherButtonTitles: nil];
                                                                     [alert setDelegate:self];
                                                                     [alert show];
                                                                     
                                                                     
                                                                 }];

}


#pragma mark - UIAlertView Delegate


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
