#import "MoreNode.h"
#import "OptionNode.h"

@implementation MoreNode

+ (MoreNode *)moreNode {
    MoreNode *node = [self node];
    node.name = [MoreNode name];

    SKLabelNode *labelNode = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT_NAME];
    [labelNode setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeRight];
    [labelNode setText:@"More..."];
    [labelNode setFontColor:[UIColor grayColor]];
    [labelNode setFontSize:18];
    [node addChild:labelNode];

    [node runAction:[SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction fadeAlphaTo:0.5 duration:1],
            [SKAction fadeAlphaTo:1 duration:1],
            [SKAction waitForDuration:0.5]
    ]]]];
    return node;
}

+ (NSString *)name {
    return @"more";
}

@end