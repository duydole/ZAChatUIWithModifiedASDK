//
//  ZAImageMessageCellNode.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/1/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAImageMessageCellNode.h"
#import "ZAImageMessageViewModel.h"

@interface ZAImageMessageCellNode()

@property ZAImageMessageViewModel           *model;
@property (nonatomic) ASNetworkImageNode    *imageNode;

@end

@implementation ZAImageMessageCellNode

- (instancetype)initWithZAImageMessage:(ZAImageMessageViewModel*)model {
    self = [super initWithZAMessageModel:model];
    if (self) {
        self.model = model;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.URL = model.imageUrl;
        _imageNode.clipsToBounds = YES;
        _imageNode.placeholderFadeDuration = 0.15;
        _imageNode.contentMode = UIViewContentModeScaleAspectFill;
        _imageNode.backgroundColor = [UIColor greenColor];
        _imageNode.style.preferredSize = CGSizeMake(0.45*[UIScreen mainScreen].bounds.size.width, 3*0.45*[UIScreen mainScreen].bounds.size.width/2);

        CGFloat cornerRadius = 20.0;
        _imageNode.cornerRoundingType = ASCornerRoundingTypeClipping;
        _imageNode.backgroundColor = [UIColor whiteColor];
        _imageNode.cornerRadius = cornerRadius;
        
        [self addSubnode:_imageNode];

    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *horizontalStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    horizontalStack.spacing = 10;
    if (self.model.isOwnerSide) {
        horizontalStack.children = @[_imageNode];
        horizontalStack.justifyContent = ASStackLayoutJustifyContentEnd;
    } else {
        horizontalStack.children = @[self.avatarNode,_imageNode];
        horizontalStack.justifyContent = ASStackLayoutJustifyContentStart;
    }
    
    ASInsetLayoutSpec *insetLayout = [[ASInsetLayoutSpec alloc] init];
    insetLayout.insets = UIEdgeInsetsMake(5, 10, 5, 10);
    insetLayout.child = horizontalStack;
    
    return insetLayout;
    
}

@end
