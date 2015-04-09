#import <Foundation/Foundation.h>

@class Stitch;

@protocol StitchTransitionProtocol <NSObject>
- (void)transitionTo:(Stitch *)stitch;
@end