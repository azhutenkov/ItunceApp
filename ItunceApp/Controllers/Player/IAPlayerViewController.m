//
//  IAPlayerViewController.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IAPlayerViewController.h"
#import "IAPlayerView.h"
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>

@interface IAPlayerViewController ()
@property (nonatomic, weak) IAPlayerView *playerView;
@property (nonatomic, strong) AVPlayer *audioPlayer;
@end

@implementation IAPlayerViewController

- (void)dealloc {
    [self unregisterFromNotifications];
}

- (void)loadView {
    IAPlayerView *playerView = [[IAPlayerView alloc] init];
    self.view = playerView;
    _playerView = playerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerToNotifications];
    __weak typeof(self) weakSelf = self;
    
    [_playerView setPanelActionBlock:^(IAPlayerViewControlType controlType) {
        if (!weakSelf) {
            return;
        }
        switch (controlType) {
            case IAPlayerViewControlPlayPause:
                if (weakSelf.audioPlayer.rate > 0) {
                    [weakSelf.audioPlayer pause];
                    [weakSelf.playerView setPlayerState:IAPlayerStatePaused];
                } else {
                    [weakSelf.audioPlayer play];
                    [weakSelf.playerView setPlayerState:IAPlayerStatePlaying];
                }
                break;
                
            default:
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                break;
        }
    }];
}

#pragma mark --IAPlayerProtocol
- (void)prepareURL:(NSURL *)url {
    _audioPlayer = [AVPlayer playerWithURL:url];
    if (_audioPlayer.error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

- (void)play {
    [_audioPlayer play];
    [_playerView setPlayerState:IAPlayerStatePlaying];
}

- (void)pause {
    [_audioPlayer pause];
    [_playerView setPlayerState:IAPlayerStatePaused];
}

- (void)setArtistName:(NSString *)artistName {
    [_playerView setArtistName:artistName];
}

- (void)setTrackName:(NSString *)trackName {
    [_playerView setTrackName:trackName];
}

- (void)setArtworkImageWithURL:(NSURL *)url {
    [_playerView setArtworkImageWithURL:url];
}

#pragma mark - Notifications
- (void)registerToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemDidFinishPlaying:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)unregisterFromNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)itemDidFinishPlaying:(NSNotification *) notification {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
