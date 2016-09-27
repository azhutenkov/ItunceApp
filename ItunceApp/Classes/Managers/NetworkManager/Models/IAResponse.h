//
//  IAResponse.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@class IASongResult;
@interface IAResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign, readonly) NSUInteger resultCount;
@property (nonnull, nonatomic, copy, readonly) NSArray<IASongResult *> *results;
+ (nonnull NSDictionary *)JSONKeyPathsByPropertyKey;
@end
