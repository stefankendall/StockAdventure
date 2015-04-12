#import "StitchScene.h"
#import "Stitch.h"
#import "OptionsNode.h"
#import "GameViewController.h"
#import "OptionNode.h"
#import "PageNode.h"
#import "MoreNode.h"

@implementation StitchScene

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size stitch:stitch delegate:delegate];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    PageNode *page = [PageNode pageNodeWithSize:self.size];
    page.name = @"page";
    [self addChild:page];
    [self addStitch:self.nextStitch];
}

- (void)addStitch:(NSString *)stitchId {
    Stitch *stitch = [[Stitch alloc] initWithStitchId:stitchId];
    PageNode *pageNode = (PageNode *) [self childNodeWithName:@"page"];
    [pageNode addParagraphForStitch:stitch];
    if ([[stitch options] count] > 0) {
        [pageNode addOptions:stitch];
    }

    if ([stitch divert]) {
        self.nextStitch = [stitch divert];
        [self showMore:YES];
    }
    else {
        self.lastStitchReached = YES;
        [self showMore:NO];
    }
}

- (void)showMore:(BOOL)moreStitches {
    MoreNode *more = (MoreNode *) [self childNodeWithName:[MoreNode name]];
    if (moreStitches) {
        if (!more) {
            more = [MoreNode moreNode];
            more.position = CGPointMake(self.size.width - 10, 10);
            [self addChild:more];
        }
    }
    else {
        [more runAction:[SKAction sequence:@[
                [SKAction fadeAlphaTo:0 duration:1],
                [SKAction removeFromParent]
        ]]];
    }
}

- (SKNode *)touchedOption:(UITouch *)touch {
    if (!touch) {
        return nil;
    }

    NSArray *touchedNodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *touchedNode in touchedNodes) {
        if (touchedNode && [touchedNode.name isEqualToString:@"option"]) {
            return (OptionsNode *) touchedNode;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastTouch = [touches anyObject];
    if (!self.lastStitchReached) {
        [self addStitch:self.nextStitch];
    }

    [(OptionNode *) [self touchedOption:[touches anyObject]] highlight];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastTouch = [touches anyObject];
    [(OptionNode *) [self touchedOption:[touches anyObject]] highlight];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *optionNode = [self touchedOption:[touches anyObject]];
    if (optionNode) {
        OptionsNode *options = (OptionsNode *) [self childNodeWithName:@"//options"];
        Stitch *nextStitch = [options stitchForNode:optionNode];
        [self.transitionDelegate transitionTo:nextStitch];
    }
}

- (void)update:(CFTimeInterval)currentTime {
    [(OptionNode *) [self touchedOption:self.lastTouch] highlight];
}

@end