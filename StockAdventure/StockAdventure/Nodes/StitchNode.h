#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NodeWithHeight.h"

@class Stitch;

extern const NSString *STITCH_FONT;

@interface StitchNode : SKNode <NodeWithHeight>

+ (StitchNode *)paragraphNodeWithStitch:(Stitch *)stitch forWidth:(int)width;

- (CGFloat)height;
@end