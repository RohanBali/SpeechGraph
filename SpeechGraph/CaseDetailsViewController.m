//
//  CaseDetailsViewController.m
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-26.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import "CaseDetailsViewController.h"
#import "RequestManager.h"
#import "AddCaseDetailsViewController.h"

@implementation CaseDetailsViewController

float gVals[] = { 1,2,2.1,4.5,4.3,4.2,6,8,9,10, 13, 5.5 };

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtons];
    [self.navigationItem setTitle:@"Case Details"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupCaseDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sutup Method

- (void)setupBarButtons {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDataButtonPressed:)];
}
- (void)setupCaseDetails {
    [self.tableView setHidden:YES];
    [self.spinnerView setHidesWhenStopped:YES];
    self.spinnerView.center = self.view.center;
    [self.spinnerView startAnimating];
    [self getCaseDetails];
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _caseDetailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"detailsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *casesDict = [self.caseDetailsArray objectAtIndex:indexPath.row];
    cell.textLabel.text  = [casesDict objectForKey:@"dataTimestamp"];
    
    return cell;
}


#pragma mark - Get Cases Methods

- (void)getCaseDetails {
    
    
    NSString *caseNumberString = [self.caseDictionary objectForKey:@"caseNumber"];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * caseNumber = [f numberFromString:caseNumberString];
    
    
    
    [[RequestManager sharedInstance] requestCaseDetailsWithCaseNumber:caseNumber
                                                              success:^(NSArray *caseDetalilsArray) {
                                                                  self.caseDetailsArray = caseDetalilsArray;
                                                                  [self.tableView reloadData];
                                                                  [self.spinnerView stopAnimating];
                                                                  [self.tableView setHidden:NO];
                                                                  
                                                                  if([self.caseDetailsArray count] == 0) {
                                                                      [self.graphDataButton setEnabled:NO];
                                                                  } else {
                                                                      [self.graphDataButton setEnabled:YES];
                                                                  }
                                                              } failure:^{
                                                                  
                                                              }];
    
}


#pragma mark - Button Methods

- (void)addDataButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCaseDetailsViewController *acdVc =[storyboard instantiateViewControllerWithIdentifier:@"addCaseDetailsViewController"];
    [acdVc setCaseNumber:[self.caseDictionary objectForKey:@"caseNumber"]];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:acdVc] animated:YES completion:nil];
}

- (void)graphDataButtonClicked:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FRD3DBarChartViewController *bcVc =[storyboard instantiateViewControllerWithIdentifier:@"barChartViewController"];
    [bcVc setFrd3dBarChartDelegate:self];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:bcVc] animated:YES completion:nil];
    
    
}

#pragma mark FRD3DBarChartViewController Delegate Methods


-(int) frd3DBarChartViewControllerNumberRows:(FRD3DBarChartViewController *)frd3DBarChartViewController
{
    return 3;
}

-(int) frd3DBarChartViewControllerNumberColumns:(FRD3DBarChartViewController *)frd3DBarChartViewController
{
    return [self.caseDetailsArray count];
}


-(float) frd3DBarChartViewController:(FRD3DBarChartViewController *)frd3DBarChartViewController valueForBarAtRow:(int)row column:(int)column
{
    NSDictionary *casesDict = [self.caseDetailsArray objectAtIndex:column];
    
    if (row == 0) {
        return [[casesDict objectForKey:@"dataX"] floatValue];
    } else if (row == 1) {
        return [[casesDict objectForKey:@"dataY"] floatValue];
    } else {
        return [[casesDict objectForKey:@"dataZ"] floatValue];
    }
}

-(float) frd3DBarChartViewControllerMaxValue:(FRD3DBarChartViewController *)frd3DBarChartViewController
{
    float max = 0.0f;
    
    for (NSDictionary *dict in self.caseDetailsArray) {
        
        if (max < [[dict objectForKey:@"dataX"] floatValue]) {
            max =[[dict objectForKey:@"dataX"] floatValue];
        } else if (max < [[dict objectForKey:@"dataY"] floatValue]) {
            max =[[dict objectForKey:@"dataY"] floatValue];
        } else if (max < [[dict objectForKey:@"dataZ"] floatValue]) {
            max =[[dict objectForKey:@"dataZ"] floatValue];
        }
    }
    
    
    return  max;
}

-(float) frd3DBarChartViewController:(FRD3DBarChartViewController *)frd3DBarChartViewController percentSizeForBarAtRow:(int)row column:(int)column
{
    return 0.7;
}


-(NSString *)frd3DBarChartViewController:(FRD3DBarChartViewController *)frd3DBarChartViewController legendForColumn:(int)column
{
    NSDictionary *casesDict = [self.caseDetailsArray objectAtIndex:column];
    return [casesDict objectForKey:@"dataTimestamp"];
}

-(NSString *) frd3DBarChartViewController:(FRD3DBarChartViewController *)frd3DBarChartViewController legendForRow:(int)row
{
    if (row == 0) {
        return @"Data X";
    } else if (row == 1) {
        return @"Data Y";
    } else {
        return @"Data Z";
    }
}

-(UIColor *) frd3DBarChartViewController:(FRD3DBarChartViewController *)frd3DBarChartViewController colorForBarAtRow:(int)row column:(int)column
{
    
    if (row == 0) {
        UIColor *color = [UIColor redColor];
        return color;
    } else if (row == 1) {
        UIColor *color = [UIColor greenColor];
        return color;
    } else {
        UIColor *color = [UIColor blueColor];
        return color;
    }
    
}

-(NSString *) frd3DBarChartViewController:(FRD3DBarChartViewController *)frd3DBarChartViewController legendForValueLine:(int)line
{
    float max = 0.0f;
    
    for (NSDictionary *dict in self.caseDetailsArray) {
        
        if (max < [[dict objectForKey:@"dataX"] floatValue]) {
            max =[[dict objectForKey:@"dataX"] floatValue];
        } else if (max < [[dict objectForKey:@"dataY"] floatValue]) {
            max =[[dict objectForKey:@"dataY"] floatValue];
        } else if (max < [[dict objectForKey:@"dataZ"] floatValue]) {
            max =[[dict objectForKey:@"dataZ"] floatValue];
        }
    }
    
    return [NSString stringWithFormat:@"Rating %f", max*(line+1)/5];
}

-(int) frd3DBarChartViewControllerNumberHeightLines:(FRD3DBarChartViewController *)frd3DBarChartViewController
{
    return 5;
}

@end
