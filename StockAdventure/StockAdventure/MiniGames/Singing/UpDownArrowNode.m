#import "UpDownArrowNode.h"

@implementation UpDownArrowNode

+ (UpDownArrowNode *)upDownArrowNode:(BOOL)up {
    UpDownArrowNode *node = [UpDownArrowNode node];
    SKSpriteNode *arrowNode = [SKSpriteNode spriteNodeWithImageNamed:@"arrowup"];
    node.alpha = 0;
    [arrowNode setYScale:up ? 1 : -1];
    [node addChild:arrowNode];
    return node;
}

@end