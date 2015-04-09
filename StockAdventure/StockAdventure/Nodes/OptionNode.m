#import "OptionNode.h"

@implementation OptionNode

const NSString *OPTION_FONT = @"Avenir-Heavy-Oblique";
const int OPTION_FONT_SIZE = 24;

+ (OptionNode *)nodeWithOption:(NSDictionary *)optionDict {
    OptionNode *option = [self node];

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT];
    [label setFontSize:OPTION_FONT_SIZE];
    [label setText:optionDict[@"option"]];
    label.name = @"label";
    [option addChild:label];
    return option;
}

- (CGFloat)height {
    return OPTION_FONT_SIZE;
}

- (void)highlight {
    [self removeActionForKey:@"removeHighlight"];
    __weak SKLabelNode *label = (SKLabelNode *) [self childNodeWithName:@"label"];
    [label setFontColor:[UIColor colorWithRed:1.00 green:1.00 blue:0.8 alpha:1.0]];
    float highlightTime = 1;
    SKAction *removeHighlight = [SKAction customActionWithDuration:highlightTime actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        [label setFontColor:[UIColor colorWithRed:1.00 green:1.00 blue:(CGFloat) (0.80 + 0.2 * elapsedTime / highlightTime) alpha:1.0]];
    }];
    [self runAction:removeHighlight withKey:@"removeHighlight"];
}

@end