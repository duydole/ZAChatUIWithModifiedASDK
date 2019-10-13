//
//  ZAIconMessageCellNode.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAIconMessage.h"
#import "ZAMessageBaseCellNode.h"
#import "ZAIconMessageViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAIconMessageCellNode : ZAMessageBaseCellNode

- (instancetype) initWithZAIconMessage:(ZAIconMessageViewModel*)model;


@end

NS_ASSUME_NONNULL_END
