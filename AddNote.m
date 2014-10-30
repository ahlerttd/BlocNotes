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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *action;


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
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextRecognizerTabbed:)];
    ///recognizer.delegate = self;
    recognizer.numberOfTapsRequired = 1;
    [self.textField addGestureRecognizer:recognizer];
    
    
}

- (void) editTextRecognizerTabbed:(UITapGestureRecognizer *) aRecognizer;
{
    self.textField.dataDetectorTypes = UIDataDetectorTypeNone;
    self.textField.editable = YES;
    [self.textField becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    self.textField.editable = NO;
    self.textField.dataDetectorTypes = UIDataDetectorTypeAll;
}


- (IBAction)share:(id)sender {
    
    NSMutableArray *sharedNote = [NSMutableArray new];
    
    if (self.titleField.text.length > 0) {
        [sharedNote addObject:self.titleField.text];
    }
    if (self.textField.text.length > 0) {
        [sharedNote addObject:self.textField.text];
    }
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharedNote applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0 || self.titleField.text.length > 0) {
        
        if(self.editNote) {
            
            if (self.titleField.text.length > 0){
                
                [self.editNote setValue:self.titleField.text forKey:@"title"];
                [self.editNote setValue:self.textField.text forKey:@"note"];
                
            } else{
                
                [self.editNote setValue:self.textField.text forKey:@"note"];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MMM d, yyyy 'at' h:mm a"];
                NSString *stringFromDate = [dateFormatter stringFromDate:[NSDate date]];
                [self.editNote setValue:stringFromDate forKey:@"title"];
                
                
            }
            
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
            if (self.titleField.text.length > 0){
                noteData.title = self.titleField.text;
            }
            else {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MMM d, yyyy 'at' h:mm a"];
                NSString *stringFromDate = [dateFormatter stringFromDate:[NSDate date]];
                noteData.title = stringFromDate;
            }
            noteData.note = self.textField.text;
            noteData.completed = @(NO);
            noteData.creationDate = [NSDate date];
            
            [context save: NULL];
            
        }
    }
}



@end