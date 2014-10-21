//
//  NotesList.h
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNote.h"

@interface NotesList : UITableViewController

@property (nonatomic, strong) NSArray *noteDataArray;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;


@end
