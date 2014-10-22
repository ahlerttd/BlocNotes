//
//  AddNote.m
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import "AddNote.h"

@interface AddNote ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation AddNote


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0) {
        self.noteItem = [[NoteItem alloc] init];
        self.noteItem.note = self.textField.text;
        self.noteItem.completed = NO;
    }
}

@end
