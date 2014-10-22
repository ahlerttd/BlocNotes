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
#import "NoteData.h"

@interface NotesList () <NSFetchedResultsControllerDelegate>

@property NSFetchedResultsController *frc;

@end

@implementation NotesList


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

    NSSortDescriptor *noteDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: noteDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];

    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:NULL cacheName:NULL];
    
    self.frc.delegate = self;
    [self.frc performFetch:NULL];
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.frc.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    NoteData *noteData = [self.frc.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = noteData.note;
   
    
    return cell;
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}




@end
