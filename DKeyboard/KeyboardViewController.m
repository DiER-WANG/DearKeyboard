//
//  KeyboardViewController.m
//  DKeyboard
//
//  Created by 王昌阳 on 2018/5/2.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "KeyboardViewController.h"
#import "DKAddressBookViewController.h"

@interface KeyboardViewController ()

@property (nonatomic, strong) UIButton          *nextKeyboardButton;
@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) UIView            *addressBookView;



@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Perform custom UI setup here
    [self configSubviews];
    [self configLayouts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark - UI
- (void)configSubviews {
    
    _contentView = [[UIView alloc] init];
    [self.inputView addSubview:_contentView];
    _contentView.backgroundColor = [UIColor yellowColor];
    
    
    
    
    
    DKAddressBookViewController *addressVC = [[DKAddressBookViewController alloc] init];
    [self addChildViewController:addressVC];
    [_contentView addSubview:addressVC.view];
    _addressBookView = addressVC.view;
    _addressBookView.backgroundColor = [UIColor blueColor];
    
    _nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_contentView addSubview:_nextKeyboardButton];
    [_nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [_nextKeyboardButton addTarget:self
                            action:@selector(handleInputModeListFromView:withEvent:)
                  forControlEvents:UIControlEventAllTouchEvents];
    _nextKeyboardButton.hidden = !self.needsInputModeSwitchKey;
    _nextKeyboardButton.backgroundColor = [UIColor greenColor];
}

- (void)configLayouts {
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.inputView);
        make.height.equalTo(@240);
    }];
    
    [_nextKeyboardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(15);
        make.height.equalTo(@34);
    }];
    
    [_addressBookView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 34, 0));
        make.top.equalTo(self.contentView);
    }];
}

- (void)dealloc {
    NSLog(@"xxxxx");
}

@end
