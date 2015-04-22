#import "PageNode.h"
#import "StitchNode.h"
#import "OptionsNode.h"
#import "Stitch.h"

@implementation PageNode

+ (PageNode *)pageNodeWithSize:(CGSize)size {
    PageNode *page = [self node];
    page.size = size;

    page.verticalPad = 20;
    page.padBetweenParagraphs = 25;
    page.horizontalPad = 10;

    return page;
}

- (CGFloat)heightOfAllParagraphs {
    __block CGFloat height = 0;
    [self enumerateChildNodesWithName:@"//paragraph" usingBlock:^(SKNode *node, BOOL *stop) {
        StitchNode *stitchNode = (StitchNode *) node;
        height += [stitchNode calculateAccumulatedFrame].size.height + self.padBetweenParagraphs;
    }];
    return height;
}

- (void)addOptions:(Stitch *)stitch {
    OptionsNode *options = [OptionsNode optionsNodeForStich:stitch
                                                   forWidth:(int) (self.size.width -
                                                           2 * self.horizontalPad)];

    options.position = CGPointMake(self.size.width / 2,
            self.size.height - self.verticalPad - [options calculateAccumulatedFrame].size.height
                    - [self heightOfAllParagraphs] - 2 * self.padBetweenParagraphs);
    options.name = @"options";
    [self addChild:options];
    __block SKNode *lowestParagraph = nil;
    [self enumerateChildNodesWithName:@"//paragraph" usingBlock:^(SKNode *node, BOOL *stop) {
        if (!lowestParagraph || node.position.y < lowestParagraph.position.y) {
            lowestParagraph = node;
        }
    }];
    [self movePageIfNecessary:options withTopNodeAndOptionsHeight:lowestParagraph.calculateAccumulatedFrame.size.height
            + options.calculateAccumulatedFrame.size.height];
}

- (void)addParagraphForStitch:(Stitch *)stitch {
    StitchNode *paragraph = [StitchNode paragraphNodeWithStitch:stitch
                                                       forWidth:(int) (self.size.width -
                                                               2 * self.horizontalPad)];

    CGFloat yPosition = self.size.height - self.verticalPad - [self heightOfAllParagraphs] - paragraph.calculateAccumulatedFrame.size.height;
    paragraph.position = CGPointMake(self.horizontalPad, yPosition);
    paragraph.name = @"paragraph";
    [self addChild:paragraph];

    [self movePageIfNecessary:paragraph withTopNodeAndOptionsHeight:paragraph.calculateAccumulatedFrame.size.height];
}

- (void)movePageIfNecessary:(SKNode *)node withTopNodeAndOptionsHeight:(CGFloat)topHeight {
    if (node.position.y < -self.position.y) {
        SKAction *moveAction = [SKAction moveToY:[self heightOfAllParagraphs] - topHeight
                        - self.verticalPad
                                        duration:1];
        moveAction.timingMode = SKActionTimingEaseIn;
        [self runAction:moveAction];
    }
}

@end