//
//  IANetworkManager.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IANetworkManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityLogger.h"
#import "IAResponse.h"

#pragma mark --Constants
NSString * const kBaseURL = @"http://itunes.apple.com/";
NSString * const kSearchRequest = @"search";

#pragma mark --Static values
static NSTimeInterval kTimeoutInterval = 15;
static IANetworkManager *_sharedManager = nil;

@interface IANetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation IANetworkManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                                     @"text/javascript", nil];
        _sessionManager.requestSerializer.timeoutInterval = kTimeoutInterval;
#if DEBUG
        [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif
    }
    return self;
}

- (BOOL)isReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)songsForKeyword:(NSString *)keyword
                success:(IASongsCompletionBlock)successBlock
                failure:(void (^)(NSError * _Nullable))failureBlock {
    NSDictionary *params = @{@"term": keyword};
    [_sessionManager GET:kSearchRequest
              parameters:params
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     NSError *error = nil;
                     IAResponse *model = [MTLJSONAdapter modelOfClass:[IAResponse class]
                                                   fromJSONDictionary:responseObject error:&error];
                     if (error) {
                         failureBlock(error);
                         return;
                     }
                     if (successBlock) {
                         successBlock(model.results);
                     }
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (failureBlock) {
                         failureBlock(error);
                     }
                 }];
}

@end
