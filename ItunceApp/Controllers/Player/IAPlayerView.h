//
//  IAPlayerView.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPlayerProtocol.h"
#import "IASongProtocol.h"

typedef NS_ENUM(NSInteger, IAPlayerViewControlType) {
    IAPlayerViewControlPlayPause,
    IAPlayerViewControlBack
};
typedef void(^IAPlayerViewPanelActionBlock)(IAPlayerViewControlType controlType);

@interface IAPlayerView: UIView<IASongProtocol>
- (void)setPlayerState:(IAPlayerStateType)state;
- (void)setPanelActionBlock:(IAPlayerViewPanelActionBlock)panelActionBlock;
@end
