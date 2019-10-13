//
//  ZAImageMessage.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/1/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAImageMessage.h"

@implementation ZAImageMessage

- (instancetype) initWithMessageWithFromUser:(ZAUser*)fromUser
                                      toUser:(ZAUser*)toUser
                                    imageUrl:(NSString*)imageUrl {
    self = [super init];
    if (self) {
        self.fromUser = fromUser;
        self.toUser = toUser;
        _imageUrl = imageUrl;
        self.type = ZAMessageTypeImage;
        self.date = [NSDate date];
    }
    return self;
}

- (id<ZAMessageViewModelProtocol>)toZAMessageViewModel {
    return [[ZAImageMessageViewModel alloc] initWithZAImageMessage:self];
}

@synthesize date;
@synthesize fromUser;
@synthesize identifier;
@synthesize toUser;
@synthesize type;

@end
