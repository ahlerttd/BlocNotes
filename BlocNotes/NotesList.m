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
@property NSArray *filteredTableData;

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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor, nil];
    
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredTableData count];
    } else {
        return [self.frc.fetchedObjects count];;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell"];
    
    if (cell == nil) {
        
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                               reuseIdentifier:@"ListPrototypeCell"];
        
    }
    
    NoteData *noteData = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView){
        NoteData *noteData = [self.filteredTableData objectAtIndex:indexPath.row];
        NSString *titleAndNote = [NSString stringWithFormat:@"%@ - %@", noteData.title, noteData.note];
        
        cell.textLabel.text = titleAndNote;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        
        NoteData *noteData = [self.frc.fetchedObjects objectAtIndex:indexPath.row];
        NSString *titleAndNote = [NSString stringWithFormat:@"%@ - %@", noteData.title, noteData.note];
        cell.textLabel.text = titleAndNote;
    }
    
    
    
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"title" ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    if(searchText.length > 0)
    {
        // Define how we want our entities to be filtered
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title contains[c] %@) OR (note contains[c] %@)", searchText, searchText];
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    NSArray* loadedEntities = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.filteredTableData = [[NSMutableArray alloc] initWithArray:loadedEntities];
    
    [self.tableView reloadData];
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.frc.fetchedObjects objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
    }
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"editNote" sender:tableView];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"editNote"]) {
        AddNote *addNote = segue.destinationViewController;
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            
            NSManagedObject *selectedNote = [self.filteredTableData objectAtIndex:[[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] row]];
            addNote.editNote = selectedNote;
        }
        
        else {
            
            NSManagedObject *selectedNote = [self.frc.fetchedObjects objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            
            
            addNote.editNote = selectedNote;
        }
        
        
    }
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
    if (self.searchDisplayController.searchResultsTableView){
        
        [self.searchDisplayController setActive:NO];
        
    }
    
}




@end
