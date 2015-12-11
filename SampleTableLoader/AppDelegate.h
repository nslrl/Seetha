//  AppDelegate.h
//  SampleTableLoader
//  Created by Seetha on 09/12/15.
//  Copyright (c) 2015 CTS. All rights reserved.

#import <UIKit/UIKit.h>

@class ListDataController;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ViewController* mViewController;
}

@property (strong, nonatomic) UIWindow*             window;
@property (strong, nonatomic) ListDataController*    mListDataController; // Maintains the JSON data

+(AppDelegate*) sharedObj; // Getting Appdelegate instance
-(void) onServiceCallResponse; // Reloading UI on service callback

@end

