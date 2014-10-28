//
//  NotesList.h
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NotesList : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *notesSearchBar;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;




@end