//
//  ZATextMessage.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/1/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZATextMessage.h"

@implementation ZATextMessage

- (instancetype)initWithMessageWithFromUser:(ZAUser *)fromUser
                                     toUser:(ZAUser *)toUser
                                    content:(NSString *)content {
    self = [super init];
    if (self) {
        self.fromUser = fromUser;
        self.toUser = toUser;
        self.content = content;
        self.date = [NSDate date];
        self.type = ZAMessageTypeText;
    }
    return self;
}

- (id<ZAMessageViewModelProtocol>)toZAMessageViewModel {
    return [[ZATextMessageViewModel alloc] initWithZATextMessage:self];
}

@synthesize date;
@synthesize fromUser;
@synthesize identifier;
@synthesize toUser;
@synthesize type;

@end
