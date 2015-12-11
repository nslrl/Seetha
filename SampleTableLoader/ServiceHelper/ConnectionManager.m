//  ConnectionManager.m
//  Created by Seetha on 09/12/15.

#import "ConnectionManager.h"
#import "ListDataController.h"

@implementation ConnectionManager

/* This class maintains the servicecalls */

#pragma mark servicecalls

/*
 @method        startDownload
 @abstract      downloading JSON data from the URL
 @param         nil
 @return        void
 */

-(void) startDownload
{
    // Downloading JSON data from the URL
    // In Download response, saving JSON data into array and then switching to UI therad to refresh the UI.

    NSString* urlString         = serviceUrl;
    NSURLRequest* urlRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSession* session       = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:urlRequest
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if( httpResponse.statusCode == 200 )
        {
            NSError *error;
            NSString*   text                    = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
            NSData* responseData                = [text dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *receivedData   = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
            
            for( NSDictionary *data in [receivedData objectForKey:@"rows"] )
            {
                if( [AppDelegate sharedObj].mListDataController != 0x0 )
                    [[AppDelegate sharedObj].mListDataController saveData:[data objectForKey:@"title"] description:[data objectForKey:@"description"] imgUrl:[data objectForKey:@"imageHref"]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedObj] onServiceCallResponse];
            });
        }
    }] resume];
}

@end
