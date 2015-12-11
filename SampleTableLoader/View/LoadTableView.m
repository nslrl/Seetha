//  LoadTableView.m
//  Created by Seetha on 09/12/15.

#import "LoadTableView.h"
#import "ListDataController.h"

@implementation LoadTableView

/* 
 This class going to do the Tableview related functionalities
 Here handled the tableview delegates and tableviewdatasource
*/

#pragma mark TableView DataSource
// Returing Number of Rows in tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(  [AppDelegate sharedObj].mListDataController != 0x0 )
        return [AppDelegate sharedObj].mListDataController.mDataList.count;
    
    return 0;
}

// Displaying data on TableView cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListData *data                  = [[AppDelegate sharedObj].mListDataController.mDataList objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = cellId;
    TableViewCell *cell             = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor            = [UIColor clearColor];
    
    if( cell == 0x0 )
    {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if( data != 0x0 )
    {
        // Displaying Title
        cell.lblTitle.text          = [data.mTitle isKindOfClass:[NSNull class]] ? stringNoTitle : data.mTitle;
        // Displaying Description
        cell.lblDescription.text    = [data.mDescription isKindOfClass:[NSNull class]] ? stringNoDescription : data.mDescription;
        // Adjusting Description frame
        [cell.lblDescription setFrame:CGRectMake(tableView.frame.origin.x, titleHeight, self.frame.size.width - imgHeight, [self getHeightForRow:indexPath.row] + cellSpace - titleHeight)];
        
        if( data.mImageSaved != 0x0 )
        {
            // Here avoiding download process for each cells
            // Laoding image from the saved data
            [cell.imgPhoto setImage:data.mImageSaved];
        }
        else
        {
            [cell.imgPhoto setImage:[UIImage imageNamed:noimage]];

            if( ![data.mImageUrl isKindOfClass:[NSNull class]] )
            {
                // Here loading image on the another thread
                // to perform the lazy image loading
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURL*  url = [NSURL URLWithString:data.mImageUrl];
                    NSData* imgData = [[NSData alloc] initWithContentsOfURL:url];
                    
                    if( imgData != 0x0 )
                    {
                        // Saving downloaded data
                        // so while scrolling we can show the downloaded data from the saved array,
                        // which will improves the performance
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.imgPhoto setImage:[UIImage imageWithData:imgData]];
                            data.mImageSaved = [UIImage imageWithData:imgData];
                        });
                    }
                });
            }
        }
    }
    
    // Adding Gradient effects to cells
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:CGRectMake(0, 0, self.frame.size.width, [self getHeightForRow:indexPath.row] + 10)];
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor lightGrayColor].CGColor, nil];
    [cell setBackgroundView:[[UIView alloc] init]];
    [cell.backgroundView.layer insertSublayer:gradient atIndex:0];

    return cell;
}

#pragma mark TableView Delegate
// Returing cell's height based on the description
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightForRow:indexPath.row] + cellSpace;
}

#pragma mark RableView Height Calculation

/*
 @method        getHeightForRow
 @abstract      calulating and retuning table cell's height based on description content
 @param         NSInteger
 @return        CGFloat
 */

-(CGFloat) getHeightForRow:(NSInteger) row
{
    // Calculating table cell height based on the text content
    ListData *data  = [[AppDelegate sharedObj].mListDataController.mDataList objectAtIndex:row];
    CGRect rect     = CGRectZero;
    
    if( data != 0x0 )
    {
        if( ![data.mDescription isKindOfClass:[NSNull class]] )
        {
            rect = [data.mDescription boundingRectWithSize:CGSizeMake(self.frame.size.width - imgHeight, 0)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:descriptionFontSize]}
                                                   context:nil];
        }
        
        if( (rect.size.height + titleHeight) < imgHeight )
            return imgHeight;
    }
    
    return rect.size.height + titleHeight + cellSpace;
}

@end
