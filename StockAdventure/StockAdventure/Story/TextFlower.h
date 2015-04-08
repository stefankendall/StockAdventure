#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TextFlower : NSObject

+ (NSArray *)linesFromText:(NSString *)text
                 withWidth:(int)width
                  fontSize:(int)fontSize;

+ (NSArray *)wordsFromSentence:(NSString *)sentence;

@end