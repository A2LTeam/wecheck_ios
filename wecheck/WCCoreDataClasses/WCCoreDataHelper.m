//
//  WCCoreDataHelper.m
//  wecheck
//
//  Created by Adam Cheung on 25/6/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import "WCCoreDataHelper.h"
#import "CHCSVParser.h"

@implementation WCCoreDataHelper

#define debug 1

#pragma mark - FILES
NSString *storeFilename = @"wecheck.sqlite";

#pragma mark - PATHS
- (NSString *)applicationDocumentsDirectory {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
    }
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
}

- (NSURL *)applicationStoresDirectory {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSURL *storesDirectory =
    [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
     URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
            if (debug==1) {
                NSLog(@"Successfully created Stores directory");}
        }
        else {NSLog(@"FAILED to create Stores directory: %@", error);}
    }
    return storesDirectory;
}

- (NSURL *)storeURL {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return [[self applicationStoresDirectory]
            URLByAppendingPathComponent:storeFilename];
}

#pragma mark - SETUP
- (id)init {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    self = [super init];
    if (!self) {return nil;}
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc]
                    initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc]
                initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    return self;
}

- (void)loadStore {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (_store) {return;} // Don't load store if it's already loaded
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeURL]
                                              options:@{NSSQLitePragmasOption: @{@"journal_mode": @"delete"}} error:&error];
    if (!_store) {NSLog(@"Failed to add store. Error: %@", error);abort();}
    else         {if (debug==1) {NSLog(@"Successfully added store: %@", _store);}}
}

- (void)setupCoreData {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self loadStore];
    
    NSManagedObject *newHistory;
    newHistory = [NSEntityDescription
                  insertNewObjectForEntityForName:@"WCUserHistory"
                  inManagedObjectContext:_context];
    
    [_context assignObject:newHistory toPersistentStore:_store];
    
}

#pragma mark - SAVING
- (void)saveContext {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save _context: %@", error);
        }
    } else {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

- (void)setupSystemData {
    
    NSString *subCatFile = [[NSBundle mainBundle] pathForResource:@"subcategory" ofType:@"csv"];
    
    CHCSVParser * p = [[CHCSVParser alloc] initWithContentsOfCSVFile:subCatFile delimiter:','];
    p.delegate = self;
    
    [p parse];
    
}



-(void) parserDidBeginDocument:(CHCSVParser *)parser
{
    _currentRow = [[NSMutableArray alloc] init];
}

-(void) parserDidEndDocument:(CHCSVParser *)parser
{
    /*
    for(int i=0;i&lt;[currentRow count];i++)
    {
        NSLog(@"%@          %@          %@",[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"0"]],[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"1"]],[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"2"]]);
    }
     */
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Parser failed with error: %@ %@", [error localizedDescription], [error userInfo]);
}

-(void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    _subCategory=[[WCSubCategory alloc]init];
}

-(void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
//    [_subCategory setObject:field forKey:[NSString stringWithFormat:@"%d",fieldIndex]];
    NSLog(@"Reading %@ %ld", field, (long)fieldIndex);

}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber
{
    [_currentRow addObject:_subCategory];
    _subCategory=nil;
}

@end
