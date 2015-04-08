#import "StitchOptionsNode.h"
#import "Stitch.h"

@implementation StitchOptionsNode

const NSString *OPTION_FONT = @"Avenir-Heavy-Oblique";
const int OPTION_FONT_SIZE = 24;

+ (StitchOptionsNode *)optionsNodeForStich:(Stitch *)stitch forWidth:(int)width {
    StitchOptionsNode *node = [self node];
    node.stitch = stitch;
    node.alpha = 0;
    [node runAction:
            [SKAction sequence:@[
                    [SKAction waitForDuration:0.5],
                    [SKAction fadeInWithDuration:1]
            ]]
    ];

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT];
    [label setFontSize:OPTION_FONT_SIZE];
    [label setText:@"A beeb"];
    [node addChild:label];
    return node;
}

- (int)height {
    return 0;
}

@end