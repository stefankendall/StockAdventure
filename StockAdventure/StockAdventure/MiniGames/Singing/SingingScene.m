#import "SingingScene.h"

@implementation SingingScene

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    [self addSharpFlatArrows];
}

- (void)addSharpFlatArrows {
    SKSpriteNode *sharpNode = [SKSpriteNode spriteNodeWithImageNamed:@"arrowup"];
    int yPosition = 100;
    [sharpNode setPosition:CGPointMake(self.size.width / 4, yPosition)];
    sharpNode.name = @"sharp";
    [self addChild:sharpNode];

    SKSpriteNode *flatNode = [SKSpriteNode spriteNodeWithImageNamed:@"arrowup"];
    [flatNode setPosition:CGPointMake(3 * self.size.width / 4, yPosition)];
    [flatNode setYScale:-1];
    flatNode.name = @"flat";
    [self addChild:flatNode];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastTouch = [touches anyObject];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastTouch = [touches anyObject];
}

- (void)update:(NSTimeInterval)currentTime {
    SKSpriteNode *sharp = (SKSpriteNode *) [self childNodeWithName:@"sharp"];
    SKSpriteNode *flat = (SKSpriteNode *) [self childNodeWithName:@"flat"];
    NSArray *touchedNodes = [self nodesAtPoint:[self.lastTouch locationInNode:self]];
    BOOL sharpTouched = NO;
    BOOL flatTouched = NO;
    for (SKNode *touchedNode in touchedNodes) {
        sharpTouched = sharpTouched || sharp == touchedNode;
        flatTouched = flatTouched || flat == touchedNode;
    }
    if( sharpTouched){
        [sharp runAction:[SKAction fadeAlphaTo:0 duration:0]];
    }
    [flat setAlpha:(CGFloat) (flatTouched ? 0.5 : 1)];
}

@end