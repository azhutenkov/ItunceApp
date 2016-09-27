//
//  IASongTableViewCell.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IASongTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface IASongTableViewCell()
@property(nonatomic, weak) UIImageView *artworkImage;
@property(nonatomic, weak) UILabel *trackNameLabel;
@property(nonatomic, weak) UILabel *artistNameLabel;
@end

@implementation IASongTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *container = self.contentView;
    container.clipsToBounds = YES;
    UIImageView *imageBgView = [[UIImageView alloc] init];
    imageBgView.clipsToBounds = YES;
    imageBgView.contentMode = UIViewContentModeScaleAspectFill;
    imageBgView.backgroundColor = [UIColor clearColor];
    [container addSubview:imageBgView];
    [imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.bottom.equalTo(self);
    }];
    _artworkImage = imageBgView;
    
    UIView *darkView = [[UIView alloc] init];
    darkView.alpha = 0.35;
    darkView.backgroundColor = [UIColor blackColor];
    [container addSubview:darkView];
    [darkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.bottom.equalTo(self);
    }];
    
    CGFloat sideOffset = 15;
    UILabel *trLabel = [[UILabel alloc] init];
    trLabel.numberOfLines = 0;
    trLabel.backgroundColor = [UIColor clearColor];
    trLabel.textAlignment = NSTextAlignmentCenter;
    trLabel.font = [UIFont systemFontOfSize:26];
    trLabel.shadowOffset = CGSizeMake(1, 1);
    trLabel.textColor = [UIColor whiteColor];
    trLabel.shadowColor = [UIColor blackColor];
    [container addSubview:trLabel];
    _trackNameLabel = trLabel;
    [trLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.top.offset(sideOffset);
        make.trailing.offset(-sideOffset);
    }];
    
    UILabel *artLabel = [[UILabel alloc] init];
    artLabel.numberOfLines = 0;
    artLabel.textAlignment = NSTextAlignmentCenter;
    artLabel.backgroundColor = [UIColor clearColor];
    artLabel.font = [UIFont systemFontOfSize:18];
    artLabel.shadowOffset = CGSizeMake(1, 1);
    artLabel.textColor = [UIColor whiteColor];
    artLabel.shadowColor = [UIColor blackColor];
    [container addSubview:artLabel];
    _artistNameLabel = artLabel;
    [artLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.offset(sideOffset);
        make.trailing.offset(-sideOffset);
        make.top.equalTo(trLabel.mas_bottom).with.offset(5);
        make.bottom.offset(-sideOffset);
    }];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    _trackNameLabel.preferredMaxLayoutWidth = CGRectGetWidth(_trackNameLabel.frame);
    _artistNameLabel.preferredMaxLayoutWidth = CGRectGetWidth(_artistNameLabel.frame);
}

#pragma mark -- IASongProtocol
- (void)setTrackName:(NSString *)trackName {
    _trackNameLabel.text = trackName;
}

- (void)setArtistName:(NSString *)artistName {
    _artistNameLabel.text = artistName;
}

- (void)setArtworkImageWithURL:(NSURL *)url {
    [_artworkImage sd_setImageWithURL:url];
}

@end
