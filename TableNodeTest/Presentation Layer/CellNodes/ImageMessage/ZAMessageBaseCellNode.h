//
//  ZAMessageBaseCellNode.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/2/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ZATextMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAMessageBaseCellNode : ASCellNode

@property (nonatomic) ASNetworkImageNode        *avatarNode;
@property (nonatomic) ASTextNode                *dateNode;
@property (nonatomic) ASTextNode                *statusNode;
@property (nonatomic) BOOL                      isSelectedContent;

- (instancetype) initWithZAMessageModel:(id<ZAMessageViewModelProtocol>) model;

@end

NS_ASSUME_NONNULL_END
