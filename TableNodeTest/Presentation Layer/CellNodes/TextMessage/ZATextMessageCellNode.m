//
//  ZATextMessageCellNode.m
//  RainforestStarter
//
//  Created by CPU11996 on 9/5/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

#import "ZATextMessageCellNode.h"
#import "Utilities.h"
#import "Definition.h"

@interface ZATextMessageCellNode()

@property ASDisplayNode             *bubbleTextNode;
@property ASTextNode                *textNode;
@property ZATextMessageViewModel    *model;

@end

@implementation ZATextMessageCellNode

- (instancetype)initWithZATextMessage:(ZATextMessageViewModel*)model {
    self = [super initWithZAMessageModel:model];
    
    if (self) {
        _model = model;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Text node:
        [self setupTextNode];

        // backgroundText
        self.bubbleTextNode = [[ASDisplayNode alloc] init];
        if (_model.isOwnerSide) {
            _bubbleTextNode.backgroundColor = [UIColor colorWithRed:0.0 green:132.0/255.0 blue:1.0 alpha:1];
        } else {
            _bubbleTextNode.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
        }

        _bubbleTextNode.cornerRoundingType = ASCornerRoundingTypeDefaultSlowCALayer;
        _bubbleTextNode.style.flexGrow = 1.0;
        _bubbleTextNode.style.flexShrink = 1.0;
        

        [self addSubnode:_bubbleTextNode];
        [self addSubnode:_textNode];

    }
    
    return self;
}

- (void)setupTextNode {
    self.isSelectedContent = NO;
    _textNode = [[ASTextNode alloc] init];
    _textNode.style.flexShrink = 1.0;
    _textNode.style.flexGrow = 1.0;
    _textNode.maximumNumberOfLines = 0;
    NSDictionary *attrs;
    if (_model.isOwnerSide) {
        attrs= @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:TEXT_SIZE], NSForegroundColorAttributeName: [UIColor whiteColor]};
    } else {
        attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:TEXT_SIZE], NSForegroundColorAttributeName: [UIColor blackColor]};
    }
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:_model.content attributes:attrs];
    _textNode.attributedText = string;
    [self.textNode addTarget:self action:@selector(didTapTextNode:) forControlEvents:ASControlNodeEventTouchUpInside];
}

- (void)didTapTextNode:(UITapGestureRecognizer*)sender {
    self.isSelectedContent = !self.isSelectedContent;
    
    if (self.isSelectedContent) {
        self.dateNode.alpha = 1.0;
        if (_model.isOwnerSide) {
            self.bubbleTextNode.backgroundColor = SELECTED_BG_COLOR_BUBBLE_OWNER_SIDE;
        } else {
            self.bubbleTextNode.backgroundColor = SELECTED_BG_COLOR_BUBBLE_FRIEND_SIDE;
        }
    } else {
        self.dateNode.alpha = 0.0;
        if (_model.isOwnerSide) {
            self.bubbleTextNode.backgroundColor = NONSELECTED_BG_COLOR_BUBBLE_OWNER_SIDE;
        } else {
            self.bubbleTextNode.backgroundColor = NONSELECTED_BG_COLOR_BUBBLE_FRIEND_SIDE;
        }
    }
    
    // animation transition:
    [self transitionLayoutWithAnimation:YES shouldMeasureAsync:YES measurementCompletion:nil];
}

- (ASLayoutSpec*)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    CGFloat cellWidth = constrainedSize.max.width;
    
    // Layout for TextNode:
    CGSize constrainRect = CGSizeMake(0.66*cellWidth, FLT_MAX);
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:TEXT_SIZE]};
    CGRect textRect = [_model.content boundingRectWithSize:constrainRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    ASCenterLayoutSpec *textInset =  [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY
                                                                                sizingOptions:ASCenterLayoutSpecSizingOptionDefault
                                                                                        child:_textNode];
    
    
    // Layout for BubbleNode:
    if (constrainedSize.min.height <= 45) {
        _bubbleTextNode.cornerRadius = constrainedSize.min.height/2;
    } else {
        _bubbleTextNode.cornerRadius = 20;
    }
    if (textRect.size.width < 20) {
        textRect.size.width = 30;
    }
    _bubbleTextNode.style.preferredSize = CGSizeMake(textRect.size.width+20, textRect.size.height+20);
    
    // Layout for BubbleNode+TextNode
    ASOverlayLayoutSpec *textOverlayLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_bubbleTextNode overlay:textInset];
    
    // Layout for [BubbleNode+TextNode, dateNode]
    ASStackLayoutSpec *subVerticalStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    subVerticalStack.spacing = 5;
    if (self.isSelectedContent) {
        ASStackLayoutSpec *statusStackLayout = [ASStackLayoutSpec horizontalStackLayoutSpec];
        statusStackLayout.child = self.statusNode;
        if (_model.isOwnerSide) {
            statusStackLayout.justifyContent = ASStackLayoutJustifyContentEnd;
        } else {
            statusStackLayout.justifyContent = ASStackLayoutJustifyContentStart;
        }
        subVerticalStack.children = @[textOverlayLayout,statusStackLayout];
    } else {
        subVerticalStack.children = @[textOverlayLayout];
    }
    
    // Layout [AvatarNode, subVerticalStack] into horizontal stack:
    ASStackLayoutSpec *horizontalStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    horizontalStack.spacing = 10;
    horizontalStack.alignItems = ASStackLayoutAlignItemsCenter;
    if (_model.isOwnerSide) {
        horizontalStack.children = @[subVerticalStack];
        horizontalStack.justifyContent = ASStackLayoutJustifyContentEnd;
    } else {
        horizontalStack.children = @[self.avatarNode,subVerticalStack];
        horizontalStack.justifyContent = ASStackLayoutJustifyContentStart;
    }
    
    // Layout: [statusNode, horizontalStack]
    ASStackLayoutSpec *verticalStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    verticalStack.spacing = 5;
    if (self.isSelectedContent) {
        ASInsetLayoutSpec *dateInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, INFINITY, 0, INFINITY) child:self.dateNode];
        verticalStack.children = @[dateInset,horizontalStack];
    } else {
        verticalStack.children = @[horizontalStack];
    }
    
    // inset of the stack
    ASInsetLayoutSpec *insetLayout = [[ASInsetLayoutSpec alloc] init];
    insetLayout.insets = UIEdgeInsetsMake(5, 10, 5, 10);
    insetLayout.child = verticalStack;

    return insetLayout;
}

@end
