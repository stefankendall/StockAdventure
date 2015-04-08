#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class Stitch;

@interface StitchOptionsNode : SKNode
@property(nonatomic, strong) Stitch *stitch;

+ (StitchOptionsNode *)optionsNodeForStich:(Stitch *)stitch forWidth:(int)width;

- (int)height;
@end