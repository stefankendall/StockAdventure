#import "OptionsNode.h"
#import "Stitch.h"
#import "OptionNode.h"

const int BETWEEN_OPTION_PADDING = 24;

@implementation OptionsNode

+ (OptionsNode *)optionsNodeForStich:(Stitch *)stitch forWidth:(int)width {
    OptionsNode *node = [self node];
    node.stitch = stitch;
    node.alpha = 0;
    [node runAction:
            [SKAction sequence:@[
                    [SKAction waitForDuration:0.5],
                    [SKAction fadeInWithDuration:1]
            ]]
    ];

    for (NSUInteger i = 0; i < [stitch.options count]; i++) {
        NSDictionary *optionDict = stitch.options[[stitch.options count] - i - 1];

        OptionNode *option = [OptionNode nodeWithOption:optionDict];
        option.name = @"option";
        option.position = CGPointMake(0, i * ([option height] + BETWEEN_OPTION_PADDING));
        [node addChild:option];
    }

    return node;
}

- (int)height {
    OptionNode *option = (OptionNode *) [self childNodeWithName:@"option"];
    return (int) ([self.stitch.options count] * ([option height] + BETWEEN_OPTION_PADDING));
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