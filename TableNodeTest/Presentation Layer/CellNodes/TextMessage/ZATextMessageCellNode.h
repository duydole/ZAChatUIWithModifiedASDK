//
//  ZATextMessageCellNode.h
//  RainforestStarter
//
//  Created by CPU11996 on 9/5/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ZATextMessage.h"
#import "ZAMessageBaseCellNode.h"

NS_ASSUME_NONNULL_BEGIN

@class ZATextMessageCellNode;

@interface ZATextMessageCellNode : ZAMessageBaseCellNode

- (instancetype) initWithZATextMessage:(ZATextMessageViewModel*)model;

@end

NS_ASSUME_NONNULL_END
