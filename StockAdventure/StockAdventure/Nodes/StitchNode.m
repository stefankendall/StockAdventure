#import "StitchNode.h"
#import "TextFlower.h"

@implementation StitchNode

const NSString *STITCH_FONT = @"Avenir";

const int fontSize = 24;
const int padBetweenLines = 10;

+ (StitchNode *)paragraphNodeWithText:(NSString *)text position:(int)position forWidth:(int)width {
    StitchNode *node = [self node];
    node.alpha = 0;

    NSArray *lines = [TextFlower linesFromText:text withWidth:width fontSize:fontSize];

    for (NSUInteger i = 0; i < [lines count]; i++) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) STITCH_FONT];
        label.text = lines[i];
        label.name = @"text";
        label.fontSize = fontSize;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        label.position = CGPointMake(0, ([lines count] - i) * (padBetweenLines + fontSize));
        [node addChild:label];
    }
    [node runAction:[SKAction fadeInWithDuration:1]];
    return node;
}

- (int)height {
    return [[self children] count] * (fontSize + padBetweenLines);
}

@end