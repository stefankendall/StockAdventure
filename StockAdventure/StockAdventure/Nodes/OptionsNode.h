#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class Stitch;

@interface OptionsNode : SKNode
@property(nonatomic, strong) Stitch *stitch;

+ (OptionsNode *)optionsNodeForStich:(Stitch *)stitch forWidth:(int)width;

- (int)height;

- (Stitch *)stitchForNode:(SKNode *)node;
@end