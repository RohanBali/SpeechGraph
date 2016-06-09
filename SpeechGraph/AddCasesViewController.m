//
//  AddCasesViewController.m
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-26.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import "AddCasesViewController.h"
#import "RequestManager.h"

@implementation AddCasesViewController

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

#pragma mark - Request Logic Methods

//- (void)requestAddCaseSuccededWithCaseNumber:()

#pragma mark - Button Methods

- (void)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addDataButtonClicked:(id)sender {

    [self requestAddCases];
}



#pragma mark - Request Methods

- (void)requestAddCases {
    [[RequestManager sharedInstance] requestAddCaseWithUserNumber:self.userNumber
                                                      andCaseName:[self.casenameTextField text]
                                                          success:^(NSNumber *caseNumber) {
                                                              [self addCasesSuccededWithCaseNumber:caseNumber];
                                                          } failure:^{
                                                              
                                                          }];
}


-(void)requestAddCaseDetailsWithCaseNumber:(NSNumber *)caseNumber {
    
    [[RequestManager sharedInstance] requestAddCaseDetailsWithCaseNumber:caseNumber
                                                                   dataX:[self.dataXTextField text]
                                                                   dataY:[self.dataYTextField text]
                                                                   dataZ:[self.dataZTextField text]
                                                                 success:^{
                                                                     [(MainViewController*)self.mainViewController setupLoggedInUser];
                                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Added Case"
                                                                                                                     message:@"Added User"
                                                                                                                    delegate:nil
                                                                                                           cancelButtonTitle:@"OK"
                                                                                                           otherButtonTitles: nil];
                                                                     [alert setDelegate:self];
                                                                     [alert show];

                                                                        
                                                                 } failure:^{
                                                                     [(MainViewController*)self.mainViewController setupLoggedInUser];
                                                                     
                                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Case created but adding data failed"
                                                                                                                     message:@"Case created but adding data failed"
                                                                                                                    delegate:nil
                                                                                                           cancelButtonTitle:@"OK"
                                                                                                           otherButtonTitles: nil];
                                                                     [alert setDelegate:self];
                                                                     [alert show];

                                                                     
                                                                 }];
}

#pragma mark - Request Helper Methods

- (void)addCasesSuccededWithCaseNumber:(NSNumber *)caseNumber {
    
    if ([self.dataXTextField text] && [self.dataYTextField text] && [self.dataZTextField text]) {
        [self requestAddCaseDetailsWithCaseNumber:caseNumber];
    } else {
        [(MainViewController*)self.mainViewController setupLoggedInUser];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Added Case"
                                                        message:@"Added User"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert setDelegate:self];
        [alert show];
    }
    
}

#pragma mark - UIAlertView Delegate


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
