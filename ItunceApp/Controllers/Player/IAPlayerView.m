//
//  IAPlayerView.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IAPlayerView.h"
#import "UIImageView+WebCache.h"

@interface IAPlayerView()
@property (nonatomic, weak) UILabel *trackNameLabel;
@property (nonatomic, weak) UILabel *artistNameLabel;
@property (nonatomic, weak) UIButton *playPauseButton;
@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, copy) IAPlayerViewPanelActionBlock panelActionBlock;
@end

@implementation IAPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark --SetupUI
- (void)setupUI {
    self.backgroundColor = [UIColor greenColor];
    [self layoutIfNeeded];
    [self createBackground];
    [self createTextTitles];
    [self createPanelContainer];
};

- (void)createBackground {
    UIImageView *imageBgView = [[UIImageView alloc] init];
    imageBgView.contentMode = UIViewContentModeScaleAspectFill;
    imageBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:imageBgView];
    [imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(self);
    }];
    _backgroundImageView = imageBgView;
    
    UIView *darkSliceView = [[UIView alloc] init];
    darkSliceView.alpha = 0.35;
    darkSliceView.backgroundColor = [UIColor blackColor];
    [self addSubview:darkSliceView];
    [darkSliceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.bottom.equalTo(self);
    }];
}

- (void)createTextTitles {
    UILabel *trackLabel = [[UILabel alloc] init];
    trackLabel.backgroundColor = [UIColor clearColor];
    trackLabel.textAlignment = NSTextAlignmentCenter;
    trackLabel.numberOfLines = 0;
    trackLabel.font = [UIFont systemFontOfSize:26];
    trackLabel.shadowOffset = CGSizeMake(1, 1);
    trackLabel.textColor = [UIColor whiteColor];
    trackLabel.shadowColor = [UIColor blackColor];
    [self addSubview:trackLabel];
    _trackNameLabel = trackLabel;
    [trackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.leading.and.trailing.offset(0);
    }];
    
    UILabel *artistLabel = [[UILabel alloc] init];
    artistLabel.textAlignment = NSTextAlignmentCenter;
    artistLabel.backgroundColor = [UIColor clearColor];
    artistLabel.numberOfLines = 0;
    artistLabel.font = [UIFont systemFontOfSize:22];
    artistLabel.shadowOffset = CGSizeMake(1, 1);
    artistLabel.textColor = [UIColor whiteColor];
    artistLabel.shadowColor = [UIColor blackColor];
    [self addSubview:artistLabel];
    _artistNameLabel = artistLabel;
    [artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.offset(0);
        make.top.equalTo(trackLabel.mas_bottom).with.offset(5).priorityHigh();
    }];
}

- (void)createPanelContainer {
    UIView *panelContainer = [[UIView alloc] init];
    [self addSubview:panelContainer];
    [panelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.multipliedBy(0.75);
    }];
    
    UIColor *tintColor = [UIColor whiteColor];
    UIButton *playPauseButton = [[UIButton alloc] init];
    playPauseButton.tintColor = tintColor;
    [playPauseButton addTarget:self action:@selector(playPauseButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
    [playPauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playPauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [panelContainer addSubview:playPauseButton];
    _playPauseButton = playPauseButton;
    CGFloat width = 100;
    CGFloat height = 100;
    [playPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
        make.top.and.left.and.bottom.offset(0);
    }];
    
    UIButton *backButton = [[UIButton alloc] init];
    backButton.tintColor = tintColor;
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [panelContainer addSubview:backButton];
    _backButton = backButton;
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
        make.top.and.right.and.bottom.offset(0);
        make.left.equalTo(playPauseButton.mas_right).with.offset(25);
    }];
}

- (void)setTrackName:(NSString *)trackName {
    _trackNameLabel.text = trackName;
    [self layoutIfNeeded];
}

- (void)setArtistName:(NSString *)artistName {
    _artistNameLabel.text = artistName;
    [self layoutIfNeeded];
}

- (void)setArtworkImageWithURL:(NSURL *)url {
    [_backgroundImageView sd_setImageWithURL:url];
}

- (void)setPlayerState:(IAPlayerStateType)state {
    _playPauseButton.selected = state == IAPlayerStatePlaying;
}

- (void)setPanelActionBlock:(IAPlayerViewPanelActionBlock)panelActionBlock {
    _panelActionBlock = panelActionBlock;
}

#pragma mark -- Control button actions
- (void)playPauseButtonClicked:(UIButton *)sender {
    if (_panelActionBlock) {
        _panelActionBlock(IAPlayerViewControlPlayPause);
    }
}

- (void)backButtonClicked:(UIButton *)sender {
    if (_panelActionBlock) {
        _panelActionBlock(IAPlayerViewControlBack);
    }
}


@end
