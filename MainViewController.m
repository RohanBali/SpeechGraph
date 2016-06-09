//
//  MainViewController.m
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-22.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "RequestManager.h"
#import "AddCasesViewController.h"
#import "CaseDetailsViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _casesArray = nil;
    [self checkIfLoggedIn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Methods

- (void)checkIfLoggedIn {
    if (self.userNumber == nil || self.userName == nil) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *lVc =[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [lVc setMainViewController:self];
        
        [self presentViewController:lVc animated:NO completion:nil];

    } else {
        [self setupLoggedInUser];
    }
}

- (void)setupLoggedInUser {
    [self.tableView setHidden:YES];
    [self.spinnerView setHidesWhenStopped:YES];
    self.spinnerView.center = self.view.center;
    [self.spinnerView startAnimating];
    [self getCases];
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _casesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *casesDict = [_casesArray objectAtIndex:indexPath.row];
    cell.textLabel.text  = [casesDict objectForKey:@"caseName"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *casesDict = [_casesArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CaseDetailsViewController *cdVc =[storyboard instantiateViewControllerWithIdentifier:@"caseDetailsViewController"];
    [cdVc setCaseDictionary:casesDict];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:cdVc animated:NO];
    
}
#pragma mark - Get Cases Methods

- (void)getCases {
    
    [[RequestManager sharedInstance] requestCasesWithUserNumber:self.userNumber
                                                        success:^(NSArray *casesArray) {
                                                            _casesArray = casesArray;
                                                            [self.tableView reloadData];
                                                            [self.spinnerView stopAnimating];
                                                            [self.tableView setHidden:NO];
                                                        } failure:^{
                                                            
                                                        }];
    
}

#pragma mark - UIButton Methods

- (void)addCasesButtonClicked:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCasesViewController *acVc =[storyboard instantiateViewControllerWithIdentifier:@"addCasesViewController"];
    acVc.userNumber = self.userNumber;
    acVc.mainViewController = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:acVc] animated:YES completion:nil];
}

@end
