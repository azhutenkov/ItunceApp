//
//  IASongProtocol.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

@protocol IASongProtocol <NSObject>

- (void)setTrackName:(NSString *)trackName;
- (void)setArtistName:(NSString *)artistName;
- (void)setArtworkImageWithURL:(NSURL *)url;

@end
