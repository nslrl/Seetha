//  ListData.h
//  Created by Seetha on 09/12/15.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListData : NSObject

// These will holds the parsed JSON data
@property (strong, nonatomic) NSString*    mTitle;
@property (strong, nonatomic) NSString*    mDescription;
@property (strong, nonatomic) NSString*    mImageUrl;
@property (strong, nonatomic) UIImage*     mImageSaved;

@end
