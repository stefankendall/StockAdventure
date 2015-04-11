#import "PageNode.h"
#import "StitchNode.h"
#import "OptionsNode.h"
#import "Stitch.h"

@implementation PageNode

+ (PageNode *)pageNodeWithSize: (CGSize)size {
    PageNode *page = [self node];
    page.size = size;
    
    page.topViewVerticalPad = 20;
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
            self.size.height - self.topViewVerticalPad - [options height] - [self heightOfAllCurrentParagraphs]);
    options.name = @"options";
    [[self childNodeWithName:@"page"] addChild:options];
}

- (void)addParagraphForStitch:(Stitch *)stitch {
    StitchNode *paragraph = [StitchNode paragraphNodeWithStitch:stitch
                                                       forWidth:(int) (self.size.width -
                                                               2 * self.horizontalPad)];
    paragraph.position = CGPointMake(self.horizontalPad,
            self.size.height - self.topViewVerticalPad - [paragraph height] - [self heightOfAllCurrentParagraphs]);
    paragraph.name = @"paragraph";
    [self addChild:paragraph];
}
@end