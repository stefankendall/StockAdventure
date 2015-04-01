#import "GameScene2.h"

@implementation GameScene2

- (void)didMoveToView:(SKView *)view {
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"World!!";
    myLabel.fontSize = 48;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:myLabel];
}

@end