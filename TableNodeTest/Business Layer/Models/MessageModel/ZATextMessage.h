//
//  ZATextMessage.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/1/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAUser.h"
#import "ZATextMessageViewModel.h"
#import "ZAMessageViewModelProtocol.h"

@protocol ZAMessageBaseProtocol <NSObject>

@property (nonatomic) NSString      *identifier;
@property (nonatomic) ZAUser        *fromUser;
@property (nonatomic) ZAUser        *toUser;
@property (nonatomic) NSDate        *date;
@property (nonatomic) ZAMessageType type;

- (id<ZAMessageViewModelProtocol>) toZAMessageViewModel;

@end

@interface ZATextMessage:NSObject<ZAMessageBaseProtocol>

@property (nonatomic) NSString      *content;
- (instancetype) initWithMessageWithFromUser:(ZAUser*)fromUser
                                      toUser:(ZAUser*)toUser
                                     content:(NSString*)content;

@end


