//
//  IASearchPanelView.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IASearchPanelView: UIView
- (void)setSearchButtonTitle: (nonnull NSString *)buttonTitle;
- (void)setSearchActionBlock:(nullable void (^)(NSString *_Nonnull text))searchActionBlock;
- (nonnull NSString *)searchText;
@end
