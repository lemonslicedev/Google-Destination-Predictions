//
//  GDPPredictionsResponse.m
//  Google Destination Predictions
//
//  Created by Yan Shcherbakov on 2013-06-30.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "GDPPredictionsResponse.h"
#import "GDPPrediction.h"

@implementation GDPPredictionsResponse

@synthesize parentParserDelegate, status, predictions;

- (id)init
{
    self = [super init];
    
    if (self) {
        predictions = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"status"]) {
        currentString = [[NSMutableString alloc] init];
        [self setStatus:currentString];
    } else if ([elementName isEqual:@"prediction"]) {
        NSLog(@"Found Prediction Element");
        GDPPrediction *prediction = [[GDPPrediction alloc] init];
        
        [prediction setParentParserDelegate:self];
        
        [parser setDelegate:prediction];
        
        [predictions addObject:prediction];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString = nil;
    
    if ([elementName isEqual:@"AutocompletionResponse"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end
