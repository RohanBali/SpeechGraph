//
//  RequestManager.h
//  SpeechGraph
//
//  Created by Rohan Bali on 2014-11-20.
//  Copyright (c) 2014 Rohan Bali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpeechGraphHTTPClient.h"
#import "Constants.h"
@interface RequestManager : NSObject

+ (RequestManager *)sharedInstance;

- (void)requestLoginWithUserName:(NSString *)username Password:(NSString *)password
                         success:(void (^)(NSString* username, NSString *userID))success
                         failure:(void (^)(void))failure;


#pragma mark - Cases
- (void)requestCasesWithUserNumber:(NSNumber *)userNumber
                         success:(void (^)(NSArray *casesArray))success
                         failure:(void (^)(void))failure;

- (void)requestAddCaseWithUserNumber:(NSNumber *)userNumber
                         andCaseName:(NSString *)caseName
                             success:(void (^)(NSNumber *caseNumber))success
                             failure:(void (^)(void))failure;

#pragma mark - Case Details

- (void)requestCaseDetailsWithCaseNumber:(NSNumber *)caseNumber
                           success:(void (^)(NSArray *caseDetalilsArray))success
                           failure:(void (^)(void))failure;

- (void)requestAddCaseDetailsWithCaseNumber:(NSNumber *)caseNumber
                                      dataX:(NSString *)datax
                                      dataY:(NSString*)datay
                                      dataZ:(NSString*)dataz
                                 success:(void (^)(void))success
                                 failure:(void (^)(void))failure;

@end
