#import "OptionNode.h"

@implementation OptionNode

const NSString *OPTION_FONT = @"Avenir-Heavy-Oblique";
const int OPTION_FONT_SIZE = 24;

+ (OptionNode *)nodeWithOption:(NSDictionary *)optionDict {
    OptionNode *option = [self node];

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT];
    [label setFontSize:OPTION_FONT_SIZE];
    [label setText:optionDict[@"option"]];
    [label setFontColor:[UIColor blackColor]];
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
    CGFloat startColor = 0.8;
    [label setFontColor:[UIColor colorWithRed:startColor green:startColor blue:0.0 alpha:1.0]];
    float highlightTime = 1;
    SKAction *removeHighlight = [SKAction customActionWithDuration:highlightTime actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        CGFloat toZeroPosition = startColor - startColor * elapsedTime / highlightTime;
        [label setFontColor:[UIColor colorWithRed:toZeroPosition green:toZeroPosition blue:0 alpha:1.0]];
    }];
    [self runAction:removeHighlight withKey:@"removeHighlight"];
}

@end