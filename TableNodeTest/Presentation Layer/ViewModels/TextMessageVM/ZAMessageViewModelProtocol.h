//
//  ZAMessageViewModelProtocol.h
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

typedef NS_ENUM(NSInteger, ZAMessageType) {
    ZAMessageTypeText  = 0,
    ZAMessageTypeImage,
    ZAMessageTypeIcon
};

typedef NS_ENUM(NSInteger, ZAMessagePosition) {
    ZAMessagePositionBegin = 0,
    ZAMessagePositionMid,
    ZAMessagePositionEnd
};

@protocol ZAMessageViewModelProtocol <NSObject>

@required
@property (nonatomic) ZAMessageType type;
@property (nonatomic) NSURL         *avatarUrl;
@property (nonatomic) NSString      *dateString;
@property (nonatomic) NSString      *status;
@property (nonatomic) BOOL          isOwnerSide;

@end
