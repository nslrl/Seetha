//  ListDataController.m
//  Created by Seetha on 09/12/15.

#import "ListDataController.h"

@implementation ListDataController

/*
 This class maintains the JSON data
 Going to save parsed JSON data into cusom list
*/

-(void) saveData:(NSString*) title description:(NSString*) description imgUrl:(NSString *) imgUrl
{
   // saving parsed JSON data into cusom list

    if( self.mDataList.count > 0 )
    {
        for( ListData* savedData in self.mDataList )
        {
            if( [savedData.mTitle isEqual:title] )
                return;
        }
    }
    
    if( self.mDataList == 0x0 )
        self.mDataList = [[NSMutableArray alloc] init];
    
    ListData *data      = [[ListData alloc] init];
    data.mTitle         = title;
    data.mDescription   = description;
    data.mImageUrl      = imgUrl;
    data.mImageSaved    = 0x0;
    [self.mDataList addObject:data];
}

@end
