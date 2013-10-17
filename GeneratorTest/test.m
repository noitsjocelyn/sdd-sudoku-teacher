/* Main function to run GeneratorTests.
 */

#import <Foundation/Foundation.h>
#import "GeneratorTests.h"

int main()
{
    GeneratorTests *unitTests = [[GeneratorTests alloc] init];
    int returnValue = [unitTests runAllTests];
    return returnValue;
}
