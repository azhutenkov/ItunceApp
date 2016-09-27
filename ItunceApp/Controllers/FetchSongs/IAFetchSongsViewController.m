//
//  IAFetchSongsViewController.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IAFetchSongsViewController.h"

#import "IASongTableViewCell.h"
#import "IASearchPanelView.h"
#import "IANetworkManager.h"
#import "IAPlayerViewController.h"

#pragma mark --Static constants
static NSInteger kMinKeywordLenght = 5;

@interface IAFetchSongsViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) IASearchPanelView *searchPanel;
@property(nonatomic, copy) NSArray<IASongResult *> *songs;
@property(nonatomic, strong) IASongTableViewCell *prototypeCell;
@end

@implementation IAFetchSongsViewController

- (void)loadView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.view = tableView;
    _tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    __weak typeof(self) weakSelf = self;
    [_searchPanel setSearchActionBlock:^(NSString * _Nonnull text) {
        [[weakSelf searchPanel] resignFirstResponder];
        if ([text length] < kMinKeywordLenght) {
            [IAErrorHandler handleErrorWithType:IAErrorHandlerErrorTypeKeywordShort];
            return;
        }
        if (![[IANetworkManager sharedManager] isReachable]) {
            [IAErrorHandler handleErrorWithType:IAErrorHandlerErrorTypeInternetNotReachable];
            return;
        }
        [self fetchKeyword:text];
    }];
    [self.view layoutIfNeeded];
}

- (void)fetchKeyword:(NSString *)keyword {
    __weak typeof(self) weakSelf = self;
    [self showHUG:YES];
    [[IANetworkManager sharedManager] songsForKeyword:keyword success:^(NSArray<IASongResult *> * _Nullable songs) {
        if (!weakSelf) {
            return;
        }
        [weakSelf showHUG:NO];
        weakSelf.songs = songs;
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        [weakSelf showHUG:NO];
        [IAErrorHandler handleError:error];
    }];
}

- (void)showHUG:(BOOL)state {
    UIView *hugContainer = self.view;
    hugContainer.userInteractionEnabled = !state;
    if (state) {
        [MBProgressHUD showHUDAddedTo:hugContainer animated:YES];
    } else {
        [MBProgressHUD hideHUDForView:hugContainer animated:YES];
    }
}

#pragma mark --Setup UI
- (void)setupTableView {
    _tableView.contentInset = UIEdgeInsetsMake(20, 0.0, 0.0, 0.0);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    IASearchPanelView *searchBar = [[IASearchPanelView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    _tableView.tableHeaderView = searchBar;
    _searchPanel = searchBar;
    [_searchPanel setSearchButtonTitle:NSLocalizedString(@"SEARCH_BUTTON_TITLE", nil)];
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        _prototypeCell = [[IASongTableViewCell alloc] initWithReuseIdentifier:@"prototypeCell"];
    } else {
        _tableView.estimatedRowHeight = 44;
    }
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return UITableViewAutomaticDimension;
    }
    
    [_prototypeCell setTrackName:[_songs objectAtIndex:indexPath.row].trackName];
    [_prototypeCell setArtistName:[_songs objectAtIndex:indexPath.row].artistName];
    [_prototypeCell layoutIfNeeded];
    return [_prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark --UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    IASongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[IASongTableViewCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    [cell setTrackName:[_songs objectAtIndex:indexPath.row].trackName];
    [cell setArtistName:[_songs objectAtIndex:indexPath.row].artistName];
    [cell setArtworkImageWithURL:[_songs objectAtIndex:indexPath.row].artworkHightResURL];
    [cell layoutIfNeeded];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _songs.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //MPMoviePlayerController is deprecated in iOS9.0
    //AVPlayerViewController avaible from iOS8.0
#warning Не хочу писать разные реализации под ios 7.0 и >= ios 8.0, создаю свой простенький контроллер audio player
    IASongResult *song = [_songs objectAtIndex:indexPath.row];
    IAPlayerViewController *playerController = [[IAPlayerViewController alloc] init];
    [self presentViewController:playerController animated:YES completion:nil];
    [playerController prepareURL:song.previewSongURL];
    [playerController setArtistName:song.artistName];
    [playerController setTrackName:song.trackName];
    [playerController setArtworkImageWithURL:song.artworkHightResURL];
    [playerController play];
}

@end
