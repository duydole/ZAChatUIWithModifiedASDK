//
//  ZATextMessageViewModel.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZATextMessageViewModel.h"

@implementation ZATextMessageViewModel

- (instancetype) initWithZATextMessage:(ZATextMessage *)textMessage {
    self = [super init];
    if (self) {
        _isOwnerSide = textMessage.fromUser.isOwner;
        if (_isOwnerSide) {
            self.avatarUrl = [NSURL URLWithString:textMessage.fromUser.avatarUrl];
        } else {
            self.avatarUrl = [NSURL URLWithString:textMessage.toUser.avatarUrl];
        }
        self.dateString = @"SEP 30, 11:57 PM";
        self.status = @"Seen";
        
        self.content = textMessage.content;
        self.type = ZAMessageTypeText;
    }
    return self;
}

@end
