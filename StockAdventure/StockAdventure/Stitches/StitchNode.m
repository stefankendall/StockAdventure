#import "StitchNode.h"
#import "TextFlower.h"
#import "Stitch.h"
#import "ImageInfo.h"

@implementation StitchNode

const NSString *STITCH_FONT = @"Avenir";

const int fontSize = 24;
const int padBetweenLines = 10;

+ (StitchNode *)paragraphNodeWithStitch:(Stitch *)stitch forWidth:(int)width {
    StitchNode *node = [self node];
    node.alpha = 0;

    NSArray *lines = [TextFlower linesFromText:[stitch content] withWidth:width fontSize:fontSize];
    CGFloat topOffset = 0;
    if ([stitch image]) {
        SKSpriteNode *imageSprite = [SKSpriteNode spriteNodeWithImageNamed:[stitch image]];
        imageSprite.name = @"image";
        CGSize imageSize = [ImageInfo sizeForImage:[stitch image]];
        [imageSprite setSize:CGSizeMake(width, imageSize.height * (width / imageSize.width))];
        imageSprite.position = CGPointMake(width / 2, 0);
        imageSprite.anchorPoint = CGPointMake(0.5, 0);
        [node addChild:imageSprite];
        topOffset = imageSprite.size.height;
    }

    for (NSUInteger i = 0; i < [lines count]; i++) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:(NSString *) STITCH_FONT];
        label.text = lines[i];
        label.name = @"text";
        label.fontSize = fontSize;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        label.fontColor = [UIColor blackColor];
        label.position = CGPointMake(0, topOffset + ([lines count] - i) * (padBetweenLines + fontSize));
        [node addChild:label];
    }

    [node runAction:[SKAction fadeInWithDuration:1]];
    return node;
}


@end