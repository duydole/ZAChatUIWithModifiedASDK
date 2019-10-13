//
//  ZAIconMessageCellNode.m
//  ZAChatUI
//
//  Created by CPU11996 on 10/3/19.
//  Copyright © 2019 vng. All rights reserved.
//

#import "ZAIconMessageCellNode.h"
#import "ZAIconMessageViewModel.h"

@interface ZAIconMessageCellNode()

@property ZAIconMessageViewModel            *model;
@property (nonatomic) ASNetworkImageNode    *imageNode;

@end

@implementation ZAIconMessageCellNode

- (instancetype)initWithZAIconMessage:(ZAIconMessageViewModel *)model {
    self = [super initWithZAMessageModel:model];
    if (self) {
        self.model = model;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.URL = model.iconUrl;
        _imageNode.clipsToBounds = YES;
        _imageNode.placeholderFadeDuration = 0.15;
        _imageNode.contentMode = UIViewContentModeScaleAspectFill;
        _imageNode.style.preferredSize = model.preferedSize;
        
        
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
