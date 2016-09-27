//
//  IAResponse.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IAResponse.h"
#import "IASongResult.h"

@implementation IAResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"results": @"results",
             @"resultCount": @"resultCount"};
}

#pragma mart --Transformers
+ (NSValueTransformer *)resultsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[IASongResult class]];
}

@end
