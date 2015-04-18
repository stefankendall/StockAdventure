#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Stitch : NSObject

@property(nonatomic, copy) NSString *stitchId;

@property(nonatomic, strong) NSDictionary *stitchDictionary;

- (instancetype)initWithStitchId:(NSString *)stitchId;

- (NSString *)lastPartOfImageFromUrl:(NSString *)url;

- (NSString *)divertIdFromData:(NSDictionary *)data;

- (NSString *)divert;

- (NSString *)image;

- (NSString *)imageFromData:(NSDictionary *)data;

+ (instancetype)stitchWithStitchId:(NSString *)stitchId;

- (NSString *)content;

- (NSArray *)options;

- (BOOL)isTheEnd;
@end