#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface UpDownArrowNode : SKNode
@property(nonatomic) int width;

+ (UpDownArrowNode *)upDownArrowNode:(BOOL)up width: (int) width;
@end