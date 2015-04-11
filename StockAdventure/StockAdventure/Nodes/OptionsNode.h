#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NodeWithHeight.h"

@class Stitch;

@interface OptionsNode : SKNode<NodeWithHeight>
@property(nonatomic, strong) Stitch *stitch;

+ (OptionsNode *)optionsNodeForStich:(Stitch *)stitch forWidth:(int)width;

- (CGFloat)height;

- (Stitch *)stitchForNode:(SKNode *)node;
@end