#import "TextFlower.h"
#import "StitchNode.h"

@implementation TextFlower

+ (NSArray *)linesFromText:(NSString *)text
                 withWidth:(int)width
                  fontSize:(int)fontSize {
    NSMutableArray *lines = [@[] mutableCopy];

    int currentLine = 0;
    for (NSString *word in [self wordsFromSentence:text]) {
        if ([lines count] < (currentLine + 1)) {
            [lines addObject:word];
        }
        else {
            NSString *newString = [NSString stringWithFormat:@"%@ %@", lines[(NSUInteger) currentLine], word];
            CGSize textSize = [newString sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:STITCH_FONT size:fontSize]}];
            if (textSize.width > width) {
                [lines addObject:word];
                currentLine++;
            }
            else {
                lines[(NSUInteger) currentLine] = newString;
            }
        }
    }

    return lines;
}

+ (NSArray *)wordsFromSentence:(NSString *)sentence {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [sentence componentsSeparatedByCharactersInSet:charSet];
}

@end