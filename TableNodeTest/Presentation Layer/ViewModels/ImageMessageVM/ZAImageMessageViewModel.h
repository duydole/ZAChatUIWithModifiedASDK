//
//  ZAImageMessageViewModel.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZAImageMessage.h"

@class ZAImageMessage;

NS_ASSUME_NONNULL_BEGIN

@interface ZAImageMessageViewModel : NSObject <ZAMessageViewModelProtocol>

@property (nonatomic) NSURL     *imageUrl;
- (instancetype) initWithZAImageMessage:(ZAImageMessage*)imageMessage;

@end

NS_ASSUME_NONNULL_END
