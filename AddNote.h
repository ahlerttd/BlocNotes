//
//  AddNote.h
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class NoteData;

@interface AddNote : UIViewController

@property NoteData *noteData;
@property (strong) NSManagedObject *editNote;

@end
