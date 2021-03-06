#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class Stitch;
@class StitchNode;

@interface PageNode : SKNode
@property(nonatomic) int verticalPad;

@property(nonatomic) int padBetweenParagraphs;

@property(nonatomic) int horizontalPad;

@property(nonatomic) CGSize size;

@property(nonatomic) BOOL scrolling;

+ (PageNode *)pageNodeWithSize:(CGSize)size;

- (void)addOptions:(Stitch *)array;

- (void)addParagraphForStitch:(Stitch *)stitch;
@end