//
//  AddNote.h
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteItem.h"

@interface AddNote : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *text;


@property NoteItem *noteItem;



@end
