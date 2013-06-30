//
//  GDPPrediction.m
//  Google Destination Predictions
//
//  Created by Yan Shcherbakov on 2013-06-30.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "GDPPrediction.h"

@implementation GDPPrediction

@synthesize parentParserDelegate, predictionTitle;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"description"]) {
        currentString   = [[NSMutableString alloc] init];
        [self setPredictionTitle:currentString];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString = nil;
    
    if ([elementName isEqual:@"prediction"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end
