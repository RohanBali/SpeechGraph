//
//  RequestManager.m
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-20.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager


#pragma mark - LifeCycle Methods

+ (RequestManager *)sharedInstance {
    static RequestManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
    
}

- (void)requestLoginWithUserName:(NSString *)username Password:(NSString *)password success:(void (^)(NSString *, NSString *))success failure:(void (^)(void))failure {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    username, @"name",
                                    password, @"pwd",
                                    nil];
        
        
        [[SpeechGraphHTTPClient sharedClient] postPath:LOGIN_API_PATH
                                          parameters:parameters
                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {

                                             
                                                 NSError *newjsonError = nil;
                                                 NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&newjsonError];
                                                 
                                                 if (newjsonError || ![dictionary objectForKey:@"username"] || ![dictionary objectForKey:@"userID"] ) {
                                                     failure();
                                                 } else {
                                                     NSString *username = [dictionary objectForKey:@"username"];
                                                     NSString *userID = [dictionary objectForKey:@"userID"];
                                                     success(username,userID);
                                                }
                                             
                                             
                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 failure();
                                             }];
    });

    
}


- (void)requestCasesWithUserNumber:(NSNumber *)userNumber success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    userNumber, @"userNumber",
                                    nil];
        
        
        [[SpeechGraphHTTPClient sharedClient] postPath:CASELIST_API_PATH
                                            parameters:parameters
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   
                                                   NSError *newjsonError = nil;
                                                   NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&newjsonError];
                                                   NSArray *casesArray = [dictionary objectForKeyedSubscript:@"array"];
                                                   success(casesArray);
                                                   
                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   failure();
                                               }];
    });
    
    
}


- (void)requestCaseDetailsWithCaseNumber:(NSNumber *)caseNumber success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    caseNumber, @"caseNumber",
                                    nil];
        
        [[SpeechGraphHTTPClient sharedClient] postPath:CASEDETAILS_API_PATH
                                            parameters:parameters
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   
                                                   NSError *newjsonError = nil;
                                                   NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&newjsonError];
                                                   NSArray *caseDetailsArray = [dictionary objectForKeyedSubscript:@"array"];
                                                   
                                                   if (caseDetailsArray == NULL) {
                                                       caseDetailsArray = nil;
                                                   }
                                                   
                                                   success(caseDetailsArray);
                                                   
                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   failure();
                                               }];
    });
}

- (void)requestAddCaseWithUserNumber:(NSNumber *)userNumber andCaseName:(NSString *)caseName success:(void (^)(NSNumber *caseNumber))success failure:(void (^)(void))failure {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    userNumber, @"userNumber",caseName,@"caseName",
                                    nil];
        
        [[SpeechGraphHTTPClient sharedClient] postPath:ADDCASE_API_PATH
                                            parameters:parameters
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   NSError *newjsonError = nil;
                                                   NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&newjsonError];
                                                   NSString *resultString = [dictionary objectForKeyedSubscript:@"result"];
                                                   
                                                   if ([resultString isEqualToString:@"TRUE"]) {
                                                       
                                                       NSNumber *caseNumber = [dictionary objectForKeyedSubscript:@"caseNumber"];

                                                       success(caseNumber);
                                                   } else {
                                                       failure();
                                                   }
                                                   
                                                   
                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   failure();
                                               }];
    });
    
}

- (void)requestAddCaseDetailsWithCaseNumber:(NSNumber *)caseNumber dataX:(NSString *)datax dataY:(NSString *)datay dataZ:(NSString *)dataz success:(void (^)(void))success failure:(void (^)(void))failure {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    caseNumber,@"caseNumber",
                                    datax,@"dataX",
                                    datay,@"dataY",
                                    dataz,@"dataZ",
                                    nil];
        
        [[SpeechGraphHTTPClient sharedClient] postPath:ADDCASEDETAIL_API_PATH
                                            parameters:parameters
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   
                                                   NSError *newjsonError = nil;
                                                   NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&newjsonError];
                                                   NSString *resultString = [dictionary objectForKeyedSubscript:@"result"];
                                                   
                                                   if ([resultString isEqualToString:@"TRUE"]) {
                                                       success();
                                                   } else {
                                                       failure();
                                                   }
                                                   
                                                   
                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   failure();
                                               }];
    });
    
    
}

@end
