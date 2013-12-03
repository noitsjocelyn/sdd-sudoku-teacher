/* The Hint class.
 * Members:
 *   theHint:
 *     The string containing the text of the hint.
 *   highlightOne:
 *        An array containing the squares that should be highlighted blue (color may change).
 *     highlightTwo:
 *        A short that contains the location to be highlighted green, if any.
 * Methods:
 *   The methods are described in the impelmentation, Hint.m.
 */

#import <Foundation/Foundation.h>
 
@interface Hint : NSObject

@property (strong) NSString *hintText;
@property (strong) NSArray *firstLevelHighlights;
@property (strong) NSNumber *secondLevelHighlight;

@end
