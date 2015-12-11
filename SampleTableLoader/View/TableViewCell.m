//  TableViewCell.m
//  Created by Seetha on 10/12/15.

#import "TableViewCell.h"

@implementation TableViewCell

/* This class prepares the cells */

/*
 @method        initWithStyle
 @abstract      preparing tableview cells
 @param         NSString
 @return        void
 */

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Title
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lblTitle.textColor = [UIColor blueColor];
        
        // Description
        self.lblDescription = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lblDescription.font = [UIFont systemFontOfSize:descriptionFontSize];
        self.lblDescription.textAlignment = NSTextAlignmentJustified;
        self.lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblDescription.numberOfLines = 0;
        self.lblDescription.textColor = [UIColor blackColor];
        self.lblDescription.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
        
        // photo
        self.imgPhoto = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        // Adding All subviews to cell
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.lblDescription];
        [self.contentView addSubview:self.imgPhoto];
    }
    
    return self;
}

/*
 @method        layoutSubviews
 @abstract      adjusting cell's frame
 @param         nil
 @return        void
 */

- (void)layoutSubviews
{
    // This function will do the cell's frame adjustment.
    int xPos = 10;
    [self.lblTitle setFrame:CGRectMake(screenBounds.origin.x + xPos, 0, screenBounds.size.width - 20, titleHeight)];
    [self.lblDescription setFrame:CGRectMake(screenBounds.origin.x + xPos, titleHeight, screenBounds.size.width - imgHeight - 20, self.lblDescription.frame.size.height)];
    [self.imgPhoto setFrame:CGRectMake(screenBounds.size.width - imgHeight - 10 , ((self.lblTitle.frame.size.height+self.lblDescription.frame.size.height) - imgHeight)/2, imgHeight, imgHeight)];
    [super layoutSubviews];
}

@end
