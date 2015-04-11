#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface OptionNode : SKNode
+ (OptionNode *)nodeWithOption:(NSDictionary *)dictionary forWidth:(CGFloat)width;

- (CGFloat)height;

- (void)highlight;
@end