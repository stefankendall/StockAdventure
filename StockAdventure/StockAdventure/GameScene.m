#import "GameScene.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 48;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:myLabel];
}

- (void)update:(CFTimeInterval)currentTime {
}

@end
