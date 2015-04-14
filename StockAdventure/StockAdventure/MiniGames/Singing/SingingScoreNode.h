#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface SingingScoreNode : SKNode
+ (SingingScoreNode *)nodeWithScore:(int)hit outOf:(NSUInteger)of;
@end