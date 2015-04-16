#import "PageNode.h"
#import "StitchNode.h"
#import "OptionsNode.h"
#import "Stitch.h"

@implementation PageNode

+ (PageNode *)pageNodeWithSize:(CGSize)size {
    PageNode *page = [self node];
    page.size = size;

    page.verticalPad = 20;
    page.padBetweenParagraphs = 20;
    page.horizontalPad = 10;

    return page;
}

- (CGFloat)heightOfAllCurrentParagraphs {
    __block CGFloat height = 0;
    [self enumerateChildNodesWithName:@"//paragraph" usingBlock:^(SKNode *node, BOOL *stop) {
        StitchNode *stitchNode = (StitchNode *) node;
        height += [stitchNode height] + self.padBetweenParagraphs;
    }];
    return height;
}

- (void)addOptions:(Stitch *)stitch {
    OptionsNode *options = [OptionsNode optionsNodeForStich:stitch
                                                   forWidth:(int) (self.size.width -
                                                           2 * self.horizontalPad)];

    options.position = CGPointMake(self.size.width / 2,
            self.size.height - [options height] - [self heightOfAllCurrentParagraphs]);
    options.name = @"options";
    [self addChild:options];
    __block SKNode <NodeWithHeight> *lowestParagraph = nil;
    [self enumerateChildNodesWithName:@"//paragraph" usingBlock:^(SKNode *node, BOOL *stop) {
        if (!lowestParagraph || node.position.y < lowestParagraph.position.y) {
            lowestParagraph = (SKNode <NodeWithHeight> *) node;
        }
    }];
    [self movePageIfNecessary:options withTopNodeAndOptionsHeight:lowestParagraph.height + options.height];
}

- (void)addParagraphForStitch:(Stitch *)stitch {
    StitchNode *paragraph = [StitchNode paragraphNodeWithStitch:stitch
                                                       forWidth:(int) (self.size.width -
                                                               2 * self.horizontalPad)];
    paragraph.position = CGPointMake(self.horizontalPad,
            self.size.height - [paragraph height] - [self heightOfAllCurrentParagraphs]);
    paragraph.name = @"paragraph";
    [self addChild:paragraph];
    [self movePageIfNecessary:paragraph withTopNodeAndOptionsHeight:paragraph.height];
}

- (void)movePageIfNecessary:(SKNode <NodeWithHeight> *)node withTopNodeAndOptionsHeight:(CGFloat) topHeight {
    if (node.position.y < self.verticalPad) {
        SKAction *moveAction = [SKAction moveToY:self.position.y + self.size.height - topHeight duration:1];
        moveAction.timingMode = SKActionTimingEaseIn;
        [self runAction:moveAction];
    }
}

@end