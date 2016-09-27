//
//  IAErrorHandler.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IAErrorHandler.h"

@implementation IAErrorHandler

+ (void)handleError:(NSError *)error {
    [self showAlert:[error localizedDescription]];
}

+ (void)handleErrorWithType:(IAErrorHandlerErrorType)errorType {
    switch (errorType) {
        case IAErrorHandlerErrorTypeInternetNotReachable:
            [self showAlert:NSLocalizedString(@"INTERNET_NOT_REACH_ERROR_TEXT", nil)];
            break;
            
        case IAErrorHandlerErrorTypeKeywordShort:
            [self showAlert:NSLocalizedString(@"KEYWORD_IS_SHORT_ERROR_TEXT", nil)];
            break;
            
        default:
            break;
    }
}

#pragma mark --Alert
+ (void)showAlert:(NSString *)text {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:text
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK_BUTTON", nil)
                                                              style:UIAlertActionStyleDefault
                                                            handler:nil];
        [alertController addAction:alertAction];
        UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootController presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:text
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK_BUTTON", nil)
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

@end
