//
//  IASongResult.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IASongResult.h"

@implementation IASongResult

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"artistName": @"artistName",
             @"trackName": @"trackName",
             @"previewSongURL": @"previewUrl",
             @"artworkSmallURL": @"artworkUrl30",
             @"artworkMediumURL": @"artworkUrl60",
             @"artworkLargeURL": @"artworkUrl100"};
}

#pragma mark --Transformers
+ (NSValueTransformer *)previewSongURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)artworkUrlSmallJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)artworkUrlMediumJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)artworkUrlLargeJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (NSURL *)artworkHightResURL {
    NSString *hightRes = [_artworkLargeURL absoluteString];
    int maxSlice = (int)[UIScreen mainScreen].bounds.size.height;
    NSString *sizeString = [NSString stringWithFormat:@"%ix%ibb", maxSlice, maxSlice];
    hightRes = [hightRes stringByReplacingOccurrencesOfString:@"100x100bb" withString:sizeString];
    return [NSURL URLWithString:hightRes];
}

@end
