//  ViewController.m
//  SampleTableLoader
//  Created by Seetha on 09/12/15.
//  Copyright (c) 2015 CTS. All rights reserved.

#import "ViewController.h"
#import "ConnectionManager.h"
#import "Reachability.h"

@interface ViewController ()    

@end

@implementation ViewController

/*
 This class interact with the download manager class to start the download precess
 Also it interacts with tableview to display the data.
*/

- (void)viewDidLoad
{
    // Going to add the Tableview into self view and start loading data
    [self createConnectionManager];
    [self loadTableView];
    [self loadActivityIndicator];
    [self.view setUserInteractionEnabled:NO];
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    // Initiating downloadprocess to get the JSON data
    [self doDownloadProcess];
}

-(void) createConnectionManager
{
    // Creating connection manager object
    if( mConnectionManager == 0x0 )
        mConnectionManager = [[ConnectionManager alloc] init];
}

#pragma mark Activity Indication
-(void) loadActivityIndicator
{
    // Adding activity indicator to the main view
    if( self.activityIndicator == 0x0 )
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.color = [UIColor blackColor];
}

-(void) stopActivityIndicator
{
    // Stops the loading indicator process
    [self.view setUserInteractionEnabled:YES];

    if( self.activityIndicator != 0x0 )
        [self.activityIndicator stopAnimating];
}

-(void) startActivityIndicator
{
    // Starting loading indicator process
    if( self.activityIndicator != 0x0 )
    {
        [self.activityIndicator startAnimating];
        [self adjustActivityIndicator];
    }
}

-(void) adjustActivityIndicator
{
    // Activity indicator frame adjustment during orientation
    if( (self.activityIndicator != 0x0) && ([self.activityIndicator isAnimating]) )
        self.activityIndicator.center = self.view.center;
}

#pragma mark Download Process
/*
 @method        doDownloadProcess
 @abstract      get the JSON data from the server
 @param         nil
 @return        void
 */

-(void) doDownloadProcess
{
    // ConnectionMager Class having servicecalls functionality.
    // Initiating service calls/Download preocess

    BOOL isNetworkConnected = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable;
    
    if( isNetworkConnected )
    {
        if( mConnectionManager != 0x0 )
        {
            [self startActivityIndicator];
            [mConnectionManager startDownload];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:stringNoNetwork message:stringNoInternetConection delegate:self cancelButtonTitle:stringOk otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark Tableview Loader

/*
 @method        loadTableView
 @abstract      adding tableview in to the main view
 @param         nil
 @return        void
 */

-(void) loadTableView
{
    // Adding Tableview into main view
    if( self.mTblListView == 0x0 )
        self.mTblListView = [[LoadTableView alloc] init];
    
    self.mTblListView.frame             = [UIScreen mainScreen].bounds;
    self.mTblListView.delegate          = self.mTblListView;
    self.mTblListView.dataSource        = self.mTblListView;
    self.mTblListView.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mTblListView];
    
    // Adding refresh control into table view to perform the refresh operation
    if( self.mRefreshControl == 0x0 )
        self.mRefreshControl = [[UIRefreshControl alloc] init];
    
    // Adding notification for UI refresh
    [self.mRefreshControl addTarget:self action:@selector(didChangedRefreshConrol:) forControlEvents:UIControlEventValueChanged];
    [self.mTblListView addSubview:self.mRefreshControl];
}

/*
 @method        reloadTableData
 @abstract      refreshing table content
 @param         nil
 @return        void
 */

-(void) reloadTableData
{
    // Going to relaod the table data
    if( self.mTblListView != 0x0 )
        [self.mTblListView reloadData];
}

#pragma mark Pulldown process
/*
 @method        didChangedRefreshConrol
 @abstract      get the updated data from the server
 @param         UIRefreshControl
 @return        void
 */

-(void) didChangedRefreshConrol:(UIRefreshControl *) refreshControl
{
    // This the notification for Table pulldown activity
    // Here doing download process to get the updated datas from the Url
    [self doDownloadProcess];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
