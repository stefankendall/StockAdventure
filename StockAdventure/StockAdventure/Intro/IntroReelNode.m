#import "IntroReelNode.h"

@implementation IntroReelNode

+ (IntroReelNode *)introReelNode:(CGSize)size {
    IntroReelNode *node = [self node];

    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@"reel"];
    int currentX = 0;
    for (NSString *path in paths) {
        NSLog(@"%@", path);
        SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:path];
        int imageHeight = 80;
        image.size = CGSizeMake(image.size.width * imageHeight / image.size.height, imageHeight);
        image.anchorPoint = CGPointMake(0, 1);
        image.position = CGPointMake(currentX, 0);
        [node addChild:image];
        currentX += image.size.width;
    }

    [node runAction:[SKAction moveByX:(-currentX+size.width) y:0 duration:[paths count] * 4]];

    return node;
}

@end