//
//  GDPPrediction.h
//  Google Destination Predictions
//
//  Created by Yan Shcherbakov on 2013-06-30.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDPPrediction : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property (nonatomic, weak) id parentParserDelegate;

@property (nonatomic, strong) NSString *predictionTitle;

@end
