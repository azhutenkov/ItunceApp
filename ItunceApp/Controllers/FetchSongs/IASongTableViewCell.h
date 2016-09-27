//
//  IASongTableViewCell.h
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASongProtocol.h"

@interface IASongTableViewCell: UITableViewCell <IASongProtocol>
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
