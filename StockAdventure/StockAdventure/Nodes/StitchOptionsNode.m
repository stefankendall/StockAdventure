#import "StitchOptionsNode.h"
#import "Stitch.h"

@implementation StitchOptionsNode

const NSString *OPTION_FONT = @"Avenir-Heavy-Oblique";
const int OPTION_FONT_SIZE = 24;
const int BETWEEN_OPTION_PADDING = 24;

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

    for (NSUInteger i = 0; i < [stitch.options count]; i++) {
        NSDictionary *dict = stitch.options[[stitch.options count] - i - 1];

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT];
        [label setFontSize:OPTION_FONT_SIZE];
        [label setText:dict[@"option"]];
        label.position = CGPointMake(0, i * (OPTION_FONT_SIZE + BETWEEN_OPTION_PADDING));
        label.name = @"option";

        [node addChild:label];
    }

    return node;
}

- (int)height {
    return [self.stitch.options count] * (OPTION_FONT_SIZE + BETWEEN_OPTION_PADDING);
}

- (Stitch *)stitchForNode:(SKNode *)node {
    NSArray *children = [self children];
    int foundIndex = -1;
    for (NSUInteger i = 0; i < [children count]; i++) {
        if (children[i] == node) {
            foundIndex = i;
            break;
        }
    }
    if (foundIndex >= 0) {
        NSDictionary *option = self.stitch.options[[self.stitch.options count] - 1 - foundIndex];
        return [Stitch stitchWithStitchId:option[@"linkPath"]];
    }

    return nil;
}
@end