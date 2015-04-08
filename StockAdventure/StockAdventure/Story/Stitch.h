#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Stitch : NSObject

@property(nonatomic, copy) NSString *stitchId;

@property(nonatomic, strong) NSDictionary *stitchDictionary;

- (instancetype)initWithStitchId:(NSString *)stitchId;

- (NSString *)divertIdFromData:(NSDictionary *)data;

- (NSString *)divert;

+ (instancetype)stitchWithStitchId:(NSString *)stitchId;

- (NSString *)content;

@end