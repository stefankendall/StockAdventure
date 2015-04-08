#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

extern const NSString *STITCH_FONT;

@interface StitchNode : SKNode

+ (StitchNode *)paragraphNodeWithText:(NSString *)text forWidth:(int)width;

- (int)height;
@end