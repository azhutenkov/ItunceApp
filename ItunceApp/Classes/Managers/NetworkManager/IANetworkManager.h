//
//  IANetworkManager.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IASongResult.h"

typedef void(^IASongsCompletionBlock)(NSArray<IASongResult *> *_Nullable songs);

@interface IANetworkManager: NSObject
+ (nonnull instancetype)sharedManager;
- (BOOL)isReachable;
- (void)songsForKeyword:(nonnull NSString *)keyword
                success:(nullable IASongsCompletionBlock)successBlock
                failure:(nullable void(^)(NSError *_Nullable error))failureBlock;
@end
