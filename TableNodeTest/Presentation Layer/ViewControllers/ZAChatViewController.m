//
//  ViewController.m
//  DemoModifiedTextureKit
//
//  Created by CPU11996 on 9/26/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAChatViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ZATextMessageCellNode.h"
#import "ZAImageMessageCellNode.h"
#import "ZAIconMessageCellNode.h"
#import "Utilities.h"
#import "Definition.h"
#import "ZAIconMessage.h"
#import "ZAImageMessageViewModel.h"
#import "ZAIconMessageViewModel.h"

@class ViewController;

// DataSource for ASTableNode
@interface ZAChatViewController (DataSource)<ASTableDataSource>
@end

// Delegate for ASTableNode
@interface ZAChatViewController (Delegate)<ASTableDelegate>
@end

// Helpers
@interface ZAChatViewController (Helpers)

- (void)fakeZAMessages;
- (void)retrieveMoreData:(void (^)(NSArray *))completion;
- (void)appendNewDataToTableNode:(NSArray*)newTextArr;

@end

@interface ZAChatViewController ()

@property (nonatomic) ASTableNode *tableNode;

@property (nonatomic) NSMutableArray<id<ZAMessageViewModelProtocol>> *messageViewModels;

@property (nonatomic) ZAUser *owner;
@property (nonatomic) ZAUser *friend;
@property (weak, nonatomic) IBOutlet UIView *chatView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSLayoutConstraint *bottomConstraint;
@property (nonatomic) NSString *messageContent;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;

@property (weak, nonatomic) IBOutlet UIStackView *extraBtnsStackView;
@property (weak, nonatomic) IBOutlet UIButton *expandBtn;

@end

@implementation ZAChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableNode];
    [self setupBottomView];
    [self setupUsers];
    [self fakeZAMessages];
}

#pragma mark - setup views:
- (void)setupNavigationBar {
    self.navigationItem.title = @"Chat View";
}

- (void)setupBottomView {
    _bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    _messageContent = @"";
    self.bottomView.backgroundColor = [UIColor whiteColor];
    _bottomConstraint = [NSLayoutConstraint constraintWithItem:_bottomView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0f constant:0];
    [self.view addConstraint:_bottomConstraint];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];

    [self setupTextView];
    
    // setup textField:
    [self.expandBtn setHidden:YES];
}

- (void)setupTextView {
    _textField.placeholder = @"Aa";
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:244.0/255.0 blue:246.0/255.0 alpha:1];
    _textField.layer.cornerRadius = _textField.frame.size.height/2;
    _textField.layer.masksToBounds = YES;
    _textField.layer.borderWidth = 0.0;
  
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textField.frame.size.height)];
    leftView.backgroundColor = _textField.backgroundColor;
    _textField.leftView = leftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setupUsers {
    _owner = [[ZAUser alloc] initWithFullName:@"Duc Linh" avatarUrl:AVATAR_URL_LE_DUY];
    _owner.isOwner = YES;
    _friend = [[ZAUser alloc] initWithFullName:@"Le Duy" avatarUrl:AVATAR_URL_LE_DUY];
}

- (void)setupTableNode {
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _tableNode.leadingScreensForBatching = 1.0;  // overriding default of 2.0
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [_tableNode setInverted:YES];
    [self.chatView addSubnode:_tableNode];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableNode.frame = self.chatView.bounds;
    self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
}


# pragma mark - Handle events:
- (void)textFieldDidChange:(UITextField*)textField {
    _messageContent = textField.text;
    if (_messageContent.length == 1) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self hideExtraBtns];
        }];
        
        [_sendMsgBtn setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
        return;
    }
    if (_messageContent.length == 0) {
        [_sendMsgBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
}

- (void)handleKeyboardNotification:(NSNotification*)notification {
    NSDictionary *userInfor = notification.userInfo;
    if (userInfor) {
        CGRect keyboardFrame = [userInfor[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        BOOL isShowingKeyboard = notification.name == UIKeyboardWillShowNotification;
        
        _bottomConstraint.constant = isShowingKeyboard? - keyboardFrame.size.height : 0;
        if (_messageContent.length == 0) {
            [_sendMsgBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        }
        
        if (isShowingKeyboard) {
            [UIView animateWithDuration:0.25 animations:^{
                [self hideExtraBtns];
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                [self showExtraBtns];
            }];
        }
    }
}

- (IBAction)tappedSendBtn:(id)sender {
    id<ZAMessageBaseProtocol> newMessage;
    if (_messageContent.length > 0) {
        newMessage = [[ZATextMessage alloc] initWithMessageWithFromUser:_owner toUser:_friend content:_messageContent];
    } else {
        NSURL *iconURL = [[NSBundle mainBundle] URLForResource:@"like" withExtension:@"png"];
        newMessage = [[ZAIconMessage alloc] initWithMessageWithFromUser:_owner toUser:_friend iconUrl:iconURL.absoluteString preferedSize:CGSizeMake(LIKE_ICON_SIZE, LIKE_ICON_SIZE)];
    }

    [self.messageViewModels insertObject:[newMessage toZAMessageViewModel] atIndex:0];
    [self.tableNode insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self resetTextField];
    [self.tableNode scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (IBAction)tappedExpandBtn:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [self showExtraBtns];
    }];
}

# pragma mark - others:
- (void)resetTextField {
    _messageContent = @"";
    _textField.text = @"";
    [_sendMsgBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
}

- (void)hideExtraBtns {
    [self.expandBtn setHidden:NO];
    [self.extraBtnsStackView setHidden:YES];
    self.extraBtnsStackView.alpha = 0.0;
}

- (void)showExtraBtns {
    [self.expandBtn setHidden:YES];
    self.extraBtnsStackView.alpha = 1.0;
    [self.extraBtnsStackView setHidden:NO];
}

@end

# pragma mark - ASTableNode DataSource
@implementation ZAChatViewController (DataSource)

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return _messageViewModels.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ZAMessageViewModelProtocol> message = _messageViewModels[indexPath.row];
    switch (message.type) {
        case ZAMessageTypeText:
            return ^{
                return [[ZATextMessageCellNode alloc] initWithZATextMessage:message];
            };
            break;
        case ZAMessageTypeImage:
            return ^{
                return [[ZAImageMessageCellNode alloc] initWithZAImageMessage:message];
            };
            break;
        case ZAMessageTypeIcon:
            return ^{
                return [[ZAIconMessageCellNode alloc] initWithZAIconMessage:message];
            };
            break;
    }
}

@end

# pragma mark - ASTableNode Delegate
@implementation ZAChatViewController (Delegate)

- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake([UIScreen mainScreen].bounds.size.width, 40),
                           CGSizeMake([UIScreen mainScreen].bounds.size.width, INFINITY));
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textField endEditing:YES];
}

- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode {
    return YES;
}

- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context {
    [self retrieveMoreData:^(NSArray *newTextArr) {
        [self appendNewDataToTableNode:newTextArr];
        [context completeBatchFetching:YES];
    }];
}

@end


// Helpers
@implementation ZAChatViewController (Helpers)

- (void)retrieveMoreData:(void (^)(NSArray *))completion {
    NSArray *newMessages = [Utilities randomMessagesWithSize:20 withFirstUser:_owner secondUser:_friend];
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(newMessages);
    });
}

- (void)appendNewDataToTableNode:(NSArray*)newTextArr {
    NSInteger section = 0;
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    NSUInteger newCount = self.messageViewModels.count + newTextArr.count;
    for (NSUInteger row = self.messageViewModels.count; row < newCount; row++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:path];
    }
    
    for (id<ZAMessageBaseProtocol> messageModel in newTextArr) {
        [_messageViewModels addObject:[messageModel toZAMessageViewModel]];
    }
    
    [self.tableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)fakeZAMessages {
    _messageViewModels = [[NSMutableArray alloc] init];
    NSArray *messages = [Utilities randomMessagesWithSize:50 withFirstUser:_owner secondUser:_friend];
    for (id<ZAMessageBaseProtocol> messageModel in messages) {
        [_messageViewModels addObject:[messageModel toZAMessageViewModel]];
    }
    
}

@end
