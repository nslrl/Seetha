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
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    // Initiating downloadprocess to get the JSON data
    [self doDownloadProcess];
}

-(void) loadActivityIndicator
{
    // Adding activity indicator to the main view
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicator];
    activityIndicator.color = [UIColor blackColor];
}

-(void) stopActivityIndicator
{
    // Stops the loading indicator process
    if( activityIndicator != 0x0 )
    {
        activityIndicator.hidden = TRUE;
        [activityIndicator stopAnimating];
    }
}

-(void) startActivityIndicator
{
    // Starting loading indicator process
    if( activityIndicator != 0x0 )
    {
        [self.view bringSubviewToFront:activityIndicator];
        activityIndicator.hidden = FALSE;
        [activityIndicator startAnimating];
        [self adjustActivityIndicator];
    }
}

-(void) adjustActivityIndicator
{
    // Activity indicator frame adjustment during orientation
    if( (activityIndicator != 0x0) && ([activityIndicator isAnimating]) )
        activityIndicator.center = self.view.center;
}

-(void) createConnectionManager
{
    // Creating connection manager object
    if( mConnectionManager == 0x0 )
        mConnectionManager = [[ConnectionManager alloc] init];
}

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

-(void) reloadTableData
{
    // Going to relaod the table data
    if( self.mTblListView != 0x0 )
        [self.mTblListView reloadData];
}

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
