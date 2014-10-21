//
//  NotesList.m
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import "NotesList.h" 
#import "AppDelegate.h"
#import "AddNote.h"
#import "NoteItem.h"
#import "NoteData.h"

@interface NotesList ()

@property NSMutableArray *note;

@end

@implementation NotesList

@synthesize noteDataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Note" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.noteDataArray = [context executeFetchRequest:fetchRequest error:&error];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [noteDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    NoteData *noteData = [noteDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = noteData.note;
   
    
    return cell;
}


- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
    AddNote *source = [segue sourceViewController];
    NoteItem *item = source.noteItem;
    
    if (item !=nil) {
        
             
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context =
        [appDelegate managedObjectContext];
        NoteData *noteData;
        noteData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Note"
                      inManagedObjectContext:context];
        noteData.note = source.noteItem.note;
        
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Note" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSError *error;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *info in fetchedObjects) {
            NSLog(@"Note: %@", [info valueForKey:@"note"]);
            
        }
        
        self.noteDataArray = [context executeFetchRequest:fetchRequest error:&error];
        [self.tableView reloadData];
        
        
        
    }
   
}



@end
