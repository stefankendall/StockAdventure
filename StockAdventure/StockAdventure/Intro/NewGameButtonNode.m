#import "NewGameButtonNode.h"
#import "OptionNode.h"

@implementation NewGameButtonNode

+ (NewGameButtonNode *)newGameButtonWithSize:(CGSize)size {
    NewGameButtonNode *newGameButtonNode = [self node];
    newGameButtonNode.size = size;

    SKLabelNode *newGameText = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT_NAME];
    [newGameText setText:@"New Game"];
    [newGameText setFontColor:[UIColor blackColor]];
    newGameText.alpha = 0.9;
    [newGameText setFontSize:48];
    SKAction *fadeInOut = [SKAction sequence:@[
            [SKAction fadeAlphaTo:0.3 duration:1],
            [SKAction fadeAlphaTo:0.9 duration:1]
    ]];
    [newGameText runAction:[SKAction repeatActionForever:fadeInOut]];
    [newGameButtonNode addChild:newGameText];
    return newGameButtonNode;
}


- (CGRect)calculateAccumulatedFrame {
    CGRect rect = [super calculateAccumulatedFrame];
    rect.size.width = self.size.width;
    rect.size.height = rect.size.height + 20;
    return rect;
}


@end