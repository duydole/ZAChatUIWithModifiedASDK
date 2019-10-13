//
//  ZAImageMessageCellNode.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/1/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ZAImageMessage.h"
#import "ZAMessageBaseCellNode.h"
#import "ZAImageMessageViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAImageMessageCellNode : ZAMessageBaseCellNode

- (instancetype) initWithZAImageMessage:(ZAImageMessageViewModel*)model;

@end

NS_ASSUME_NONNULL_END
