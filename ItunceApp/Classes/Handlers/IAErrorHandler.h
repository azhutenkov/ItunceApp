//
//  IAErrorHandler.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IAErrorHandlerErrorType) {
    IAErrorHandlerErrorTypeInternetNotReachable,
    IAErrorHandlerErrorTypeKeywordShort
};

@interface IAErrorHandler : NSObject
+ (void)handleError:(NSError *)error;
+ (void)handleErrorWithType:(IAErrorHandlerErrorType)errorType;
@end
