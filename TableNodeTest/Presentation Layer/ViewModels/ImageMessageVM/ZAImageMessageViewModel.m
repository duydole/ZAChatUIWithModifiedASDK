//
//  ZAImageMessageViewModel.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAImageMessageViewModel.h"
#import "ZAImageMessage.h"

@implementation ZAImageMessageViewModel

- (instancetype)initWithZAImageMessage:(ZAImageMessage *)imageMessage {
    self = [super init];
    if (self) {
        self.isOwnerSide = imageMessage.fromUser.isOwner;
        if (self.isOwnerSide) {
            self.avatarUrl = [NSURL URLWithString:imageMessage.fromUser.avatarUrl];
        } else {
            self.avatarUrl = [NSURL URLWithString:imageMessage.toUser.avatarUrl];
        }
        self.dateString = @"SEP 30, 11:57 PM";
        self.status = @"Seen";
        self.imageUrl = [NSURL  URLWithString:imageMessage.imageUrl];
        self.type = ZAMessageTypeImage;
    }
    return self;
}

@synthesize avatarUrl;
@synthesize dateString;
@synthesize isOwnerSide;
@synthesize status;
@synthesize type;

@end
