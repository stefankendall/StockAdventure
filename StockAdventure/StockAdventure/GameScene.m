#import "GameScene.h"
#import "Stitch.h"
#import "StitchNode.h"
#import "StitchOptionsNode.h"

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch {
    self = [super initWithSize:size];
    if (self) {
        self.topViewVerticalPad = 40;
        self.padBetweenParagraphs = 40;
        self.horizontalPad = 10;
        self.pageStartStitch = stitch;
        self.nextStitch = stitch;
        self.lastStitchReached = NO;
    }

    return self;
}

- (void)didMoveToView:(SKView *)view {
    [self addStitch:self.nextStitch];
}

- (void)addStitch:(NSString *)stitchId {
    Stitch *stitch = [[Stitch alloc] initWithStitchId:stitchId];

    StitchNode *paragraph = [StitchNode paragraphNodeWithText:[stitch content]
                                                     forWidth:(int) (self.size.width -
                                                             2 * self.horizontalPad)];

    paragraph.position = CGPointMake(self.horizontalPad,
            self.size.height - self.topViewVerticalPad - [paragraph height] - [self heightOfAllCurrentParagraphs]);
    paragraph.name = @"paragraph";
    [self addChild:paragraph];

    if ([[stitch options] count] > 0) {
        StitchOptionsNode *options = [StitchOptionsNode optionsNodeForStich:stitch
                                                                   forWidth:(int) (self.size.width -
                                                                           2 * self.horizontalPad)];

        options.position = CGPointMake(self.size.width / 2,
                self.size.height - self.topViewVerticalPad - [options height] - [self heightOfAllCurrentParagraphs]);
        options.name = @"options";
        [self addChild:options];
    }

    if ([stitch divert]) {
        self.nextStitch = [stitch divert];
    }
    else {
        self.lastStitchReached = YES;
    }
}

- (CGFloat)heightOfAllCurrentParagraphs {
    __block CGFloat height = 0;
    [self enumerateChildNodesWithName:@"//paragraph" usingBlock:^(SKNode *node, BOOL *stop) {
        StitchNode *stitchNode = (StitchNode *) node;
        height += [stitchNode height] + self.padBetweenParagraphs;
    }];
    return height;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.lastStitchReached) {
        [self addStitch:self.nextStitch];
    }
}

- (void)update:(CFTimeInterval)currentTime {
}

@end