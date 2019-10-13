//
//  ZAIconMessageViewModel.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZAMessageViewModelProtocol.h"
#import "ZAIconMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAIconMessageViewModel :NSObject<ZAMessageViewModelProtocol>

@property (nonatomic) NSURL     *iconUrl;
@property (nonatomic) CGSize    preferedSize;
- (instancetype) initWithZAIconMessage:(ZAIconMessage*)iconMessage;

@end

NS_ASSUME_NONNULL_END
