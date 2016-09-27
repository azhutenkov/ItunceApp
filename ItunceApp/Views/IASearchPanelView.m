//
//  IASearchPanelView.m
//  ItunceApp
//
//  Created by Zhutenkov Alexei on 27/09/16.
//  Copyright © 2016 Zhutenkov Alexei. All rights reserved.
//

#import "IASearchPanelView.h"

@interface IASearchPanelView()<UISearchBarDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UIButton *searchButton;
@property (nonatomic, copy) void (^searchActionBlock)(NSString *text);
@end

@implementation IASearchPanelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self layoutIfNeeded];
    UIView *container = [[UIView alloc] init];
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.trailing.and.leading.offset(0);
    }];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.delegate = self;
    [container addSubview:searchBar];
    _searchBar = searchBar;
    
    UIButton *searchButton = [[UIButton alloc] init];
    searchButton.backgroundColor = [UIColor blueColor];
    [searchButton addTarget:self action:@selector(searchBarSearchButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:searchButton];
    _searchButton = searchButton;
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.top.and.bottom.offset(0);
        make.trailing.equalTo(searchButton.mas_leading).with.offset(0).priorityHigh();
    }];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(60));
        make.height.equalTo(@(44));
        make.trailing.offset(0);
        make.centerY.equalTo(self);
    }];
}

- (void)setSearchButtonTitle:(NSString *)buttonTitle {
    [_searchButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (void)setSearchActionBlock:(void (^)(NSString *text))searchActionBlock {
    _searchActionBlock = searchActionBlock;
}

- (NSString *)searchText {
    return _searchBar.text;
}

- (BOOL)resignFirstResponder {
    [_searchBar resignFirstResponder];
    return [super resignFirstResponder];
}

#pragma mark --UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(id)sender {
    if (_searchActionBlock) {
        _searchActionBlock(_searchBar.text);
    }
}

@end

