//  ListDataController.h
//  Created by Seetha on 09/12/15.

#import <Foundation/Foundation.h>
#import "ListData.h"

@interface ListDataController : NSObject

// Holds the JSON data to display it in Tabelview
@property (strong, nonatomic) NSMutableArray* mDataList;

-(void) saveData:(NSString*) title description:(NSString*) description imgUrl:(NSString *) imgUrl;

@end
