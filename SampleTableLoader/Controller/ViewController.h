//  ViewController.h
//  SampleTableLoader
//  Created by Seetha on 09/12/15.
//  Copyright (c) 2015 CTS. All rights reserved.

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoadTableView.h"
#import "ConnectionManager.h"

@interface ViewController : UIViewController
{
    ConnectionManager*          mConnectionManager; // Manages the Service calls
}

@property(strong, nonatomic) UIActivityIndicatorView*       activityIndicator; // Loading indication
@property(strong, nonatomic) UIRefreshControl*              mRefreshControl; // Refresh controll, which will do the pull down activity
@property(strong, nonatomic) LoadTableView*                 mTblListView; // Tableview

-(void) reloadTableData;
-(void) loadActivityIndicator;
-(void) startActivityIndicator;
-(void) stopActivityIndicator;
-(void) adjustActivityIndicator;

@end

