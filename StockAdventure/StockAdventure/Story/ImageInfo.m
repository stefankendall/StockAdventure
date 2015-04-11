#import "ImageInfo.h"

@implementation ImageInfo

+ (CGSize)sizeForImage:(NSString *)imageName {
    CGSize value;
    [@{
            @"office.png" : [NSValue valueWithCGSize:CGSizeMake(453, 306)]

    }[imageName] getValue:&value];
    return value;
}


@end