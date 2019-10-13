//
//  ZATextMessageViewModel.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZATextMessage.h"
#import "ZAMessageViewModelProtocol.h"

@class ZATextMessage;
typedef NS_ENUM(NSInteger,ZAMessageType);

@interface ZATextMessageViewModel : NSObject<ZAMessageViewModelProtocol>

@property (nonatomic) ZAMessageType type;
@property (nonatomic) NSURL         *avatarUrl;
@property (nonatomic) NSString      *dateString;
@property (nonatomic) NSString      *status; // seen or not
@property (nonatomic) BOOL          isOwnerSide;

@property (nonatomic) NSString      *content;
- (instancetype) initWithZATextMessage:(ZATextMessage*)textMessage;

@end


