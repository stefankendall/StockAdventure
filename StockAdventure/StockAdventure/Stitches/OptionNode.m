#import "OptionNode.h"
#import "TextFlower.h"

const NSString *OPTION_FONT_NAME = @"Baskerville";

@implementation OptionNode

const int OPTION_FONT_SIZE = 24;
const int padBetweenOptionLines = 4;

+ (OptionNode *)nodeWithOption:(NSDictionary *)optionDict forWidth:(CGFloat)width {
    OptionNode *option = [self node];

    NSArray *lines = [TextFlower linesFromText:optionDict[@"option"] withWidth:(int) width fontSize:OPTION_FONT_SIZE];
    for (NSUInteger i = 0; i < [lines count]; i++) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT_NAME];
        label.text = lines[i];
        label.name = @"label";
        label.fontSize = OPTION_FONT_SIZE;
        label.fontColor = [UIColor blackColor];
        label.position = CGPointMake(0, ([lines count] - i) * (padBetweenOptionLines + OPTION_FONT_SIZE));
        [option addChild:label];
    }

    return option;
}

- (void)highlight {
    [self removeActionForKey:@"removeHighlight"];
    [self enumerateChildNodesWithName:@"label" usingBlock:^(SKNode *node, BOOL *stop) {
        SKLabelNode *label = (SKLabelNode *) node;
        CGFloat startColor = 0.8;
        [label setFontColor:[UIColor colorWithRed:startColor green:startColor blue:0.0 alpha:1.0]];
        float highlightTime = 1;
        SKAction *removeHighlight = [SKAction customActionWithDuration:highlightTime actionBlock:^(SKNode *currentNode, CGFloat elapsedTime) {
            CGFloat toZeroPosition = startColor - startColor * elapsedTime / highlightTime;
            [label setFontColor:[UIColor colorWithRed:toZeroPosition green:toZeroPosition blue:0 alpha:1.0]];
        }];
        [self runAction:removeHighlight withKey:@"removeHighlight"];
    }];
}

@end