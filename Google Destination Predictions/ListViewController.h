//
//  ListViewController.h
//  Google Destination Predictions
//
//  Created by Yan Shcherbakov on 2013-06-30.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDPPredictionsResponse;

@interface ListViewController : UITableViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate>
{
    NSURLConnection *googleConnection;
    NSMutableData *xmlData;
    
    GDPPredictionsResponse *response;
}

- (void)fetchEntries;
@end
