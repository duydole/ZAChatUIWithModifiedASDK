//
//  ZAMessageBaseCellNode.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/2/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAMessageBaseCellNode.h"
#import "Definition.h"

@interface ZAMessageBaseCellNode()

@property id<ZAMessageViewModelProtocol> model;

@end

@implementation ZAMessageBaseCellNode

- (instancetype)initWithZAMessageModel:(id<ZAMessageViewModelProtocol>)model {
    self = [super init];
    if (self) {
        _model = model;
        
        [self setupDateNode];
        [self setupStatusNode];
        [self setupAvatarNode];
        
        [self addSubnode:self.dateNode];
        [self addSubnode:self.statusNode];
        [self addSubnode:self.avatarNode];
    }
    return self;
}

- (void)setupAvatarNode {
    self.avatarNode = [[ASNetworkImageNode alloc] init];
    self.avatarNode.URL = _model.avatarUrl;    
    self.avatarNode.style.preferredSize = CGSizeMake(42, 42);
    self.avatarNode.cornerRoundingType = ASCornerRoundingTypePrecomposited;
    self.avatarNode.cornerRadius = 21;
}

- (void)setupDateNode {
    self.dateNode = [[ASTextNode alloc] init];
    self.dateNode.style.flexShrink = 1.0;
    self.dateNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:DESCRIPTION_TEXT_SIZE], NSForegroundColorAttributeName:DESCRIPTION_TEXT_COLOR};
    NSAttributedString *dateString = [[NSAttributedString alloc] initWithString:_model.dateString attributes:attrs];
    self.dateNode.attributedText = dateString;
}

- (void)setupStatusNode {
    self.statusNode = [[ASTextNode alloc] init];
    self.statusNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:DESCRIPTION_TEXT_SIZE], NSForegroundColorAttributeName:DESCRIPTION_TEXT_COLOR};
    NSAttributedString *dateString = [[NSAttributedString alloc] initWithString:@"Seen" attributes:attrs];
    self.statusNode.attributedText = dateString;
}

@end
