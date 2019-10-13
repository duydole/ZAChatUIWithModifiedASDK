//
//  Utilities.m
//  ZAContactPicker2
//
//  Created by CPU11996 on 9/17/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "Utilities.h"
#import "ZAModelImageCache.h"
#import "ZATextMessage.h"
#import "ZAImageMessage.h"

#define IMAGE_SIZE 50.0
#define TEXT_SIZE 25.0

@implementation Utilities

+ (UIImage *) circledAvatartWithFullName:(NSString *)fullName {
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(IMAGE_SIZE, IMAGE_SIZE)];
    CGRect imageRect = CGRectMake(0, 0, IMAGE_SIZE, IMAGE_SIZE);
    
    UIColor *backgroundColor = [self generateColorByString:fullName];
    NSString *shortName = [self generateShortStringFrom:fullName];
    
    UIImage *renderedImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        // Draw Circle:
        CGContextSetFillColorWithColor(rendererContext.CGContext, [backgroundColor CGColor]);
        CGContextAddEllipseInRect(rendererContext.CGContext, imageRect);
        CGContextDrawPath(rendererContext.CGContext, kCGPathFill);
        
        // Draw shortName:
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        NSDictionary *attrs = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:TEXT_SIZE], NSParagraphStyleAttributeName: paragraphStyle,
                                NSForegroundColorAttributeName: [UIColor whiteColor]};
        CGRect shortNameRect = CGRectMake(0, IMAGE_SIZE/2.0 - TEXT_SIZE/2.0 - 2.0, IMAGE_SIZE, IMAGE_SIZE- 2*(IMAGE_SIZE/2.0 - TEXT_SIZE/2.0));
        [shortName drawWithRect:shortNameRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    }];

    return renderedImage;
}

+ (NSString*) generateShortStringFrom:(NSString*)fullName {
    NSArray *subStrings = [fullName componentsSeparatedByString:@" "];
    NSString *shortName = @"";
    for (NSString *subString in subStrings) {
        if (subString.length > 0) {
            shortName = [[NSString alloc] initWithFormat:@"%@%@",shortName, [subString substringToIndex:1]];
            if (shortName.length == 2) {
                break;
            }
        }
    }
    return shortName;
}

+ (UIColor*) generateColorByString:(NSString*)string {
        NSInteger colorCode = 0;
        if (string.length > 4) {
            char secondChar = [string characterAtIndex:4];
            colorCode = [[NSNumber numberWithChar:secondChar] integerValue]%5;
        }
        
        switch (colorCode) {
            case 0:
                return [UIColor colorWithRed:163.0/255.0 green:200.0/255.0 blue:218.0/255.0 alpha:1.0];
                break;
            case 1:
                return [UIColor colorWithRed:182.0/255.0 green:184.0/255.0 blue:233.0/255.0 alpha:1.0];
                break;
            case 2:
                return [UIColor colorWithRed:150.0/255.0 green:211.0/255.0 blue:196.0/255.0 alpha:1.0];
                break;
            case 3:
                return [UIColor colorWithRed:204.0/255.0 green:174.0/255.0 blue:161.0/255.0 alpha:1.0];     // rgb(204, 174, 161)
                break;
            case 4:
                return [UIColor colorWithRed:239.0/255.0 green:187.0/255.0 blue:157.0/255.0 alpha:1.0];     // rgb(239, 187, 157)
                break;
            default:
                return [UIColor colorWithRed:163.0/255.0 green:200.0/255.0 blue:218.0/255.0 alpha:1.0];
                break;
        }
}

// get Random String
+ (NSString *)getRandomString {
    int index = arc4random_uniform((int)[self sampleStrings].count);
    return [self sampleStrings][index];
}

// get Random Image
+ (NSString *)getRandomImage {
    int index = arc4random_uniform((int)[self sampleImageUrls].count);
    return [self sampleImageUrls][index];
}

+ (NSArray*) sampleStrings {
    return @[@"Hello",
             @"What are you doing?",
             @"I'm researching Texture",
             @"Where are you from?",
             @"I'm 22 years old",
             @"Texture basic unit is the node",
             @"Texture basic unit is the node. Texture basic unit is the node",
             @"To keep its user interface smooth and responsive, your app should render at 60 frames per second — the gold standard on iOS. ",
             ];
}

+ (NSArray*) sampleImageUrls {
    return @[@"https://www.guidedogs.org/wp-content/uploads/2019/08/website-donate-mobile.jpg",
             @"https://image.dhgate.com/0x0s/f2-albu-g6-M01-F8-13-rBVaR1rXM1-AI7GCAAag0_H6iAs486.jpg/dorimytrader-quality-soft-simulation-animal.jpg",
             @"https://images-na.ssl-images-amazon.com/images/I/515wjJQt2nL._SY445_.jpg",
             @"https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684&w=678&h=381",
             @"https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/captain-america-winter-soldier-1558864125.jpg?crop=0.528xw:1.00xh;0.0143xw,0&resize=480:*"
             ];
}

// random Messages
+ (NSArray<id<ZAMessageBaseProtocol>> *)randomMessagesWithSize:(NSInteger)count
                                                 withFirstUser:(ZAUser *)firstUser
                                                    secondUser:(ZAUser *)secondUser {
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    for (int i =0; i < count; i++) {
        id<ZAMessageBaseProtocol> message;
        // from firstUser -> secondUser
        if (arc4random_uniform(2) > 0) {
            if (arc4random_uniform(15) > 0) {
                // textMessage:
                message = [[ZATextMessage alloc] initWithMessageWithFromUser:firstUser
                                                                      toUser:secondUser
                                                                     content:[self getRandomString]];
            } else {
                // imageMessage:
                message = [[ZAImageMessage alloc] initWithMessageWithFromUser:firstUser
                                                                       toUser:secondUser
                                                                     imageUrl:[self getRandomImage]];
            }
            
        } else {
            // from secondUser -> firstUser
            if (arc4random_uniform(15) > 0) {
                // textMessage:
                message = [[ZATextMessage alloc] initWithMessageWithFromUser:secondUser
                                                                      toUser:firstUser
                                                                     content:[self getRandomString]];
            } else {
                // imageMessage:
                message = [[ZAImageMessage alloc] initWithMessageWithFromUser:secondUser
                                                                       toUser:firstUser
                                                                     imageUrl:[self getRandomImage]];
            }
        }
        
        [messages addObject:message];
    }
    return messages;
}


@end
