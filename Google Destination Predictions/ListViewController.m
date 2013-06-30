//
//  ListViewController.m
//  Google Destination Predictions
//
//  Created by Yan Shcherbakov on 2013-06-30.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "ListViewController.h"
#import "GDPPredictionsResponse.h"
#import "GDPPrediction.h"

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        [self fetchEntries];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%@", [response predictions]);
    return [[response predictions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    GDPPrediction *prediction = [[response predictions] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[prediction predictionTitle]];
    
    return cell;
}

- (void)fetchEntries
{
    xmlData = [[NSMutableData alloc] init];
    
    NSString *apiKey = @"AIzaSyA0cpJ5DfLniRaQ0eKxw8jVZunPuVJf6cE";
    NSString *input = @"Toronto";
    NSString *location = @"44.0500,-79.4500";
    
    //TODO: Concatenate string on multiple lines, create a baseurl and later get the data from the plist.
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/xml?input=%@&location=%@&radius=500&sensor=true&key=%@", input, location, apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    googleConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *xmlCheck = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    NSLog(@"xmlCheck = %@", xmlCheck);
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    [parser setDelegate:self];
    
    [parser parse];
    
    xmlData = nil;
    
    connection = nil;
    
    [[self tableView] reloadData];
    //NSLog(@"%@\n %@\n", response, [response status]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    googleConnection = nil;
    xmlData = nil;
    NSString *errorString = [NSString stringWithFormat:@"Fetch Failed: %@", [error localizedDescription]];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [av show];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"AutocompletionResponse"]) {
        response = [[GDPPredictionsResponse alloc] init];
        
        [response setParentParserDelegate:self];
        
        [parser setDelegate:response];
        
    }
}

@end