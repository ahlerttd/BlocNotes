//
//  AddNote.m
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import "AddNote.h"
#import "NoteData.h"
#import "AppDelegate.h"

@interface AddNote ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;


@end

@implementation AddNote


- (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 if (self.editNote) {
     [self.titleField setText:[self.editNote valueForKey:@"title"]];
     [self.textField setText:[self.editNote valueForKey:@"note"]];
 
 }
 
 }

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0 || self.titleField.text.length > 0) {
        
        if(self.editNote) {
            
            [self.editNote setValue:self.titleField.text forKey:@"title"];
            [self.editNote setValue:self.textField.text forKey:@"note"];
            
        }
        
        else
        {
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context =
        [appDelegate managedObjectContext];
        NoteData *noteData;
        noteData = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Note"
                    inManagedObjectContext:context];
        noteData.note = self.textField.text;
        noteData.title = self.titleField.text;
        noteData.completed = @(NO);
        noteData.creationDate = [NSDate date];
        
        [context save: NULL];
        
        }
    }
}

@end