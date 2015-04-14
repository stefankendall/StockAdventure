#import "UpDownArrowNode.h"

@implementation UpDownArrowNode

+ (UpDownArrowNode *)upDownArrowNode:(BOOL)up width: (int) width{
    UpDownArrowNode *node = [UpDownArrowNode node];
    node.width = width;
    SKSpriteNode *arrowNode = [SKSpriteNode spriteNodeWithImageNamed:@"arrowup"];
    node.alpha = 0;
    [arrowNode setYScale:up ? 1 : -1];
    [node addChild:arrowNode];
    return node;
}

- (CGRect)calculateAccumulatedFrame {
    CGRect rect = [super calculateAccumulatedFrame];
    rect.size.width = self.width;
    return rect;
}


@end