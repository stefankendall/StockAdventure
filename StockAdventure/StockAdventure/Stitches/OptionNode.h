#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

extern const NSString *OPTION_FONT_NAME;

@interface OptionNode : SKNode
+ (OptionNode *)nodeWithOption:(NSDictionary *)dictionary forWidth:(CGFloat)width;

- (CGFloat)height;

- (void)highlight;
@end