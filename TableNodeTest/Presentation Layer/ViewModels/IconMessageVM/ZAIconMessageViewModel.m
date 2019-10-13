//
//  ZAIconMessageViewModel.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAIconMessageViewModel.h"

@implementation ZAIconMessageViewModel

- (instancetype)initWithZAIconMessage:(ZAIconMessage *)iconMessage {
    self = [super init];
    if (self) {
        self.isOwnerSide = iconMessage.fromUser.isOwner;
        if (self.isOwnerSide) {
            self.avatarUrl = [NSURL URLWithString:iconMessage.fromUser.avatarUrl];
        } else {
            self.avatarUrl = [NSURL URLWithString:iconMessage.toUser.avatarUrl];
        }
        self.dateString = @"SEP 30, 11:57 PM";
        self.status = @"Seen";
        
        self.iconUrl = [NSURL URLWithString:iconMessage.iconUrl];
        self.preferedSize = iconMessage.preferedSize;
        self.type = ZAMessageTypeIcon;
        
    }
    return self;
}

@synthesize avatarUrl;
@synthesize dateString;
@synthesize isOwnerSide;
@synthesize status;
@synthesize type;

@end
