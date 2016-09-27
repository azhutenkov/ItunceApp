//
//  IASongResult.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Mantle.h"

@interface IASongResult: MTLModel<MTLJSONSerializing>
@property (nonnull, nonatomic, copy, readonly) NSString *artistName;
@property (nonnull, nonatomic, copy, readonly) NSString *trackName;
@property (nonnull, nonatomic, copy, readonly) NSURL *previewSongURL;
@property (nonnull, nonatomic, copy, readonly) NSURL *artworkSmallURL;
@property (nonnull, nonatomic, copy, readonly) NSURL *artworkMediumURL;
@property (nonnull, nonatomic, copy, readonly) NSURL *artworkLargeURL;
@property (nonnull, readonly) NSURL *artworkHightResURL;
+ (nonnull NSDictionary *)JSONKeyPathsByPropertyKey;
@end
