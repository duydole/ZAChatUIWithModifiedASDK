//
//  ZAUser.h
//  ZAChatUI
//
//  Created by Duy on 9/29/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZAUser : NSObject

@property (nonatomic) NSString          *identifier;
@property (nonatomic) NSString          *fullName;
@property (nonatomic) NSArray<ZAUser*>  *friends;
@property (nonatomic) NSString          *avatarUrl;
@property (nonatomic) BOOL              isOwner;

- (instancetype) initWithFullName:(NSString*)fullName
                        avatarUrl:(NSString*)avatarUrl;

@end
