//
//  ViewController.h
//  FolderWatch
//
//  Created by burnsoft on 2/14/17.
//  Copyright © 2017 burnsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MHWDirectoryWatcher.h"

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *txtPath;
- (IBAction)startMonitor:(id)sender;
- (IBAction)stopMonitor:(id)sender;
@property (nonatomic, strong) MHWDirectoryWatcher *directoryWatcher;
- (void) changesDetected;
@property (weak) IBOutlet NSTextField *lblResults;
@property (weak) IBOutlet NSButton *btnStart;
@property (weak) IBOutlet NSButton *btnStop;

@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTableView *myTableView;
- (IBAction)btnClearTable:(id)sender;


@end

