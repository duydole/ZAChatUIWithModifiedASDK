//
//  ZAIconMessage.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZATextMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAIconMessage : NSObject<ZAMessageBaseProtocol>

@property (nonatomic) NSString      *iconUrl;
@property (nonatomic) CGSize        preferedSize;
- (instancetype) initWithMessageWithFromUser:(ZAUser*)fromUser
                                      toUser:(ZAUser*)toUser
                                     iconUrl:(NSString*)iconUrl
                                preferedSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
