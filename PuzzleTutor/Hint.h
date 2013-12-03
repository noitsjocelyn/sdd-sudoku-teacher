/* The Hint class.
 * Members:
 *   hintText:
 *     The string containing the text of the hint.
 *   firstLevelHighlights:
 *     An array containing the squares "in the area" that should be highlighted.
 *   secondLevelHighlight:
 *     The location of a specific square to be highlighted.
 * Methods:
 *   No public methods.
 */

#import <Foundation/Foundation.h>
 
@interface Hint : NSObject

@property (strong) NSString *hintText;
@property (strong) NSArray *firstLevelHighlights;
@property (strong) NSNumber *secondLevelHighlight;

@end
