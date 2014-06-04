//
//  ViewController.m
//  JSON_POC
//
//  Created by Wai Lok Tsang on 6/3/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "ItemShopPrice.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //NSString *key = @"ip";
    //NSString *value = @"1.1.1.1";
    //NSString *urlAsString = [NSString stringWithFormat:@"http://validate.jsontest.com/?json={%@:%@}", key, value];
    //NSString *urlAsString = [NSString stringWithFormat:@"http://ip.jsontest.com/"];
    
    //NSString *urlAsString = [NSString stringWithFormat:@"http://www.ktslopez.bugs3.com/index.php?itemCode=%@", @"P000000322"];
    //NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    //NSLog(@"%@", urlAsString);
    
    
    
    //NSLog(@"params:%@", params);
    //NSMutableURLRequest *request = [self createUrlRequest:@"http://ip.jsontest.com/"
    //                                       withHttpMethod:@"POST"
    //                                           withParams:params];
    /*
     //NSString *params = @"json={\"id\":\"123\",\"name\":\"ken\"}";
     NSString *params = @"json=[{\"id\":\"123\",\"name\":\"ken\"},{\"id\":\"123\",\"name\":\"ken\"}]";
     NSMutableURLRequest *request = [self createUrlRequest:@"http://validate.jsontest.com/"
     withHttpMethod:@"POST"
     withParams:params];
     */
    
    NSString *params = [NSString stringWithFormat:@"itemCode=%@", @"P000000322"];
    NSMutableURLRequest *request = [self createUrlRequest:@"http://www.ktslopez.bugs3.com/index.php"
                                           withHttpMethod:@"POST"
                                               withParams:params];
    
    NSLog(@"url:%@  params:%@", request.URL, params);
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        //[NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        /*
         NSError *localError = nil;
         
         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
         
         NSString *result = [parsedObject valueForKey:@"ip"];
         */
        //NSString *result = [self getStringValue:@"upd_date" fromData:data];
        
        //NSLog(@"upd_date=%@", result);
        
        NSError *localError = nil;
        NSArray *results = [self getItemShopPriceFromJSON:data error:&localError];
        for (NSDictionary *itemShopPrice in results) {
            NSLog([itemShopPrice valueForKey:@"shop"]);
            NSLog([itemShopPrice valueForKey:@"date"]);
            NSLog([itemShopPrice valueForKey:@"price"]);
        }
        
    }];
    
}

- (NSString *) getStringValue:(NSString *)key fromData:(NSData *)data {
    
    NSError *localError = nil;
    
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    
    NSString *result = [parsedObject valueForKey:key];
    
    return result;
}

- (NSArray *)getItemShopPriceFromJSON:(NSData *)data error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"pricings"];
    //    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        
        ItemShopPrice *itemShopPrice = [[ItemShopPrice alloc] init];
        
        for (NSString *key in groupDic) {
            NSLog(@"%@", key);
            if ([itemShopPrice respondsToSelector:NSSelectorFromString(key)]) {
                [itemShopPrice setValue:[groupDic valueForKey:key] forKey:key];
                NSLog(@"%@", [groupDic valueForKey:key]);
            }
        }
        
        [groups addObject:itemShopPrice];
    }
    
    return groups;
}

- (NSMutableURLRequest *) createUrlRequest:(NSString *)url withHttpMethod:(NSString *)method withParams:(NSString *)params {
    
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = method; //"POST" "GET"
    
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%lu", [data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    return request;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
