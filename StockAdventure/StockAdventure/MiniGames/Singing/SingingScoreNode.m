#import "SingingScoreNode.h"

@implementation SingingScoreNode

+ (SingingScoreNode *)nodeWithScore:(int)score outOf:(NSUInteger)total {
    SingingScoreNode *node = [self node];

    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
    [scoreLabel setFontSize:92];
    [scoreLabel setFontColor:[UIColor redColor]];
    [scoreLabel setText:[NSString stringWithFormat: @"%d / %d", score, total]];
    [node addChild:scoreLabel];

    return node;
}

@end