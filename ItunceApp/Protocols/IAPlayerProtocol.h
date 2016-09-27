//
//  IAPlayerProtocol.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

typedef NS_ENUM(NSInteger, IAPlayerStateType) {
    IAPlayerStateOff,
    IAPlayerStatePlaying,
    IAPlayerStatePaused
};

@protocol IAPlayerProtocol <NSObject>

/* @brief Prepare player for play sound. Must call before run play*/
- (void)prepareURL:(NSURL *)url;
- (void)play;
- (void)pause;


@end
