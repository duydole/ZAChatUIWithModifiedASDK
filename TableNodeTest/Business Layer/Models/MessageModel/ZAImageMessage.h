//
//  ZAImageMessage.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/1/19.
//  Copyright © 2019 vng. All rights reserved.
//


#import "ZATextMessage.h"
#import "ZAImageMessageViewModel.h"

@interface ZAImageMessage : NSObject<ZAMessageBaseProtocol>

@property (nonatomic) NSString      *imageUrl;

- (instancetype) initWithMessageWithFromUser:(ZAUser*)fromUser
                                      toUser:(ZAUser*)toUser
                                    imageUrl:(NSString*)imageUrl;
@end


