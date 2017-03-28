//
//  ViewController.m
//  FolderWatch
//
//  Created by burnsoft on 2/14/17.
//  Copyright © 2017 burnsoft. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
{
    NSMutableArray *myresults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblResults.stringValue = @"";
    self.btnStop.enabled = NO;
    
    [[self myTableView] setDataSource:self];
    [[self myTableView] setDelegate:self];
    myresults = [NSMutableArray new];

    [[self myTableView] reloadData];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startMonitor:(id)sender {
    NSString *path = self.txtPath.stringValue;
    self.btnStart.enabled = NO;
    self.btnStop.enabled = YES;
    self.directoryWatcher = [MHWDirectoryWatcher directoryWatcherAtPath:path callback:^{[self changesDetected];}];
}

- (IBAction)stopMonitor:(id)sender {
    MHWDirectoryWatcher *obj = [MHWDirectoryWatcher new];
    if (obj.stopWatching) {
        NSLog(@"Monitoring stopped!");
    } else {
        NSLog(@"unable to stop");
    }
    self.btnStart.enabled = YES;
    self.btnStop.enabled = NO;
    
}
- (void) changesDetected
{
    NSString *results = [NSString stringWithFormat:@"%@",self.directoryWatcher.FileFound];
    self.lblResults.stringValue = results;
    [myresults addObject:results];
    NSLog(@"%@",results);
    [[self myTableView] reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    NSInteger iAns = [myresults count];
    return iAns;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    id returnValue=nil;
    NSString *columnIdentifer = [aTableColumn identifier];
     NSString *theName = [myresults objectAtIndex:rowIndex];

    if ([columnIdentifer isEqualToString:@"colCell"]) {
        returnValue = theName;
       
    }
    NSLog(@"%@",returnValue);
    
    return returnValue;
}

-(void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger) rowIndex
{
    //NSDictionary *row = [self.data objectAtIndex:rowIndex];
    
    NSString *columnIdentifier = [aTableColumn identifier];
    
    [myresults setValue:anObject forKey:columnIdentifier];
}

- (IBAction)btnClearTable:(id)sender {
    [myresults removeAllObjects];
    [_myTableView reloadData];
    
}
@end
