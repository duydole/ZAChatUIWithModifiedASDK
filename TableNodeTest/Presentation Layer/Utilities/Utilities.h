//
//  Utilities.h
//  ZAContactPicker2
//
//  Created by CPU11996 on 9/17/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZATextMessage.h"



@interface Utilities : NSObject

+ (UIImage*) circledAvatartWithFullName:(NSString*)fullName;

+ (NSArray<id<ZAMessageBaseProtocol>>*) randomMessagesWithSize:(NSInteger)count
                                                 withFirstUser:(ZAUser*)firstUser
                                                    secondUser:(ZAUser*)secondUser;

@end


