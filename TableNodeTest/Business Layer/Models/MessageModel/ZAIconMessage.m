//
//  ZAIconMessage.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAIconMessage.h"
#import "ZAIconMessageViewModel.h"

@implementation ZAIconMessage

- (instancetype)initWithMessageWithFromUser:(ZAUser *)fromUser toUser:(ZAUser *)toUser iconUrl:(NSString *)iconUrl preferedSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.fromUser = fromUser;
        self.toUser = toUser;
        self.iconUrl = iconUrl;
        self.preferedSize = size;
        self.type = ZAMessageTypeIcon;
    }
    return self;
}

- (id<ZAMessageViewModelProtocol>)toZAMessageViewModel {
    return [[ZAIconMessageViewModel alloc] initWithZAIconMessage:self];
}

@synthesize date;
@synthesize fromUser;
@synthesize identifier;
@synthesize toUser;
@synthesize type;

@end
