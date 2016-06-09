//
//  SafeHeartHTTPClient.m
//  SafeHeart
//
//  Created by Rohan Bali on 2013-02-09.
//  Copyright (c) 2013 Marc Fiume. All rights reserved.
//

#import "SpeechGraphHTTPClient.h"
#import "Constants.h"

@implementation SpeechGraphHTTPClient

#pragma mark - LifeCycle Methods

+ (SpeechGraphHTTPClient *)sharedClient {
    static SpeechGraphHTTPClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_API_PATH]];
    });
    
    return _sharedClient;
}


@end
