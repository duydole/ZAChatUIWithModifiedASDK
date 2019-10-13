//
//  ZAUser.m
//  ZAChatUI
//
//  Created by Duy on 9/29/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAUser.h"
#import "Utilities.h"
#import "Definition.h"

@interface ZAUser()

@end

@implementation ZAUser

- (instancetype)initWithFullName:(NSString *)fullName
                       avatarUrl:(NSString *)avatarUrl {
    self = [super init];
    if (self) {
        _fullName = fullName;
        _avatarUrl = avatarUrl;
        _isOwner = NO;
    }
    return self;
}

@end
