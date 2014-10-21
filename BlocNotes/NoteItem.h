//
//  NoteItem.h
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/20/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteItem : NSObject

@property NSString *note;
@property BOOL completed;
@property (readonly) NSDate *creationDate;


@end
