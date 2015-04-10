#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class Stitch;

extern const NSString *STITCH_FONT;

@interface StitchNode : SKNode

+ (StitchNode *)paragraphNodeWithStitch:(Stitch *)stitch forWidth:(int)width;

- (int)height;
@end