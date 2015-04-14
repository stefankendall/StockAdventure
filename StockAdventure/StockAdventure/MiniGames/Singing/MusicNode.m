#import "MusicNode.h"

@implementation MusicNode

+ (MusicNode *)musicNodeForSize:(CGSize)size {
    MusicNode *node = [self node];
    node.heightOfMusic = 150;
    node.barWidth = 10;

    SKShapeNode *topLine = [SKShapeNode shapeNodeWithRect:CGRectMake(0, node.heightOfMusic, size.width, node.barWidth)];
    topLine.fillColor = [UIColor blackColor];
    [node addChild:topLine];

    SKShapeNode *bottomLine = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, size.width, node.barWidth)];
    bottomLine.fillColor = [UIColor blackColor];
    [node addChild:bottomLine];

    SKSpriteNode *microphone = [SKSpriteNode spriteNodeWithImageNamed:@"946-microphone-selected"];
    microphone.color = [UIColor redColor];
    microphone.colorBlendFactor = 1;
    microphone.name = @"indicator";
    microphone.position = CGPointMake(30, node.heightOfMusic / 2);
    [node addChild:microphone];

    return node;
}

- (void)move:(BOOL)up timeInterval:(NSTimeInterval)interval {
    SKSpriteNode *indicator = (SKSpriteNode *) [self childNodeWithName:@"indicator"];
    int pixelsPerSecond = 200;
    int direction = up ? 1 : -1;
    CGFloat newYPosition = (CGFloat) (indicator.position.y + interval * pixelsPerSecond * direction);

    int bottom = (int) (self.barWidth + indicator.size.height / 2);
    int top = (int) (self.heightOfMusic - indicator.size.height / 2);
    newYPosition = newYPosition < bottom ? bottom : newYPosition;
    newYPosition = newYPosition > top ? top : newYPosition;
    indicator.position = CGPointMake(indicator.position.x, newYPosition);
}

@end