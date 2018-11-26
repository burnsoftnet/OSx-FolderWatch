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
/*!
    @brief When the Form Loads
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblResults.stringValue = @"";
    self.btnStop.enabled = NO;
    
    [[self myTableView] setDataSource:self];
    [[self myTableView] setDelegate:self];
    myresults = [NSMutableArray new];

    [[self myTableView] reloadData];
}

/*!
 @brief Update the View, is already loaded
 */
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

/*!
 @brief Start monitoring the selected folder
 */
- (IBAction)startMonitor:(id)sender {
    NSString *path = self.txtPath.stringValue;
    self.btnStart.enabled = NO;
    self.btnStop.enabled = YES;
    self.directoryWatcher = [MHWDirectoryWatcher directoryWatcherAtPath:path callback:^{[self changesDetected];}];
}
/*!
 @brief Stop monitoring the selected folder
 */
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
/*!
    @brief Function to add the result to the array when a change has been detected
 */
- (void) changesDetected
{
    NSString *results = [NSString stringWithFormat:@"%@",self.directoryWatcher.FileFound];
    self.lblResults.stringValue = results;
    [myresults addObject:results];
    NSLog(@"%@",results);
    [[self myTableView] reloadData];
}
/*!
 @brief Set the number of rows in the Table
 */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    NSInteger iAns = [myresults count];
    return iAns;
}
/*!
 @brief Add to Table View
 */
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
/*!
 @brief  Add Object value for table view
 */
-(void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger) rowIndex
{
    //NSDictionary *row = [self.data objectAtIndex:rowIndex];
    
    NSString *columnIdentifier = [aTableColumn identifier];
    
    [myresults setValue:anObject forKey:columnIdentifier];
}
/*!
 @brief Button to clear the array and table of the results that have been saved
 */
- (IBAction)btnClearTable:(id)sender {
    [myresults removeAllObjects];
    [_myTableView reloadData];
    
}
/*!
 @brief Button to open the directory that we are watching in finder
 */
- (IBAction)btnShowInFinder:(id)sender {
    NSURL *fileURL = [NSURL fileURLWithPath: self.txtPath.stringValue];
    NSArray *fileURLs = [NSArray arrayWithObjects:fileURL, /* ... */ nil];
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:fileURLs];
}
@end
