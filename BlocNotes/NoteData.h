//
//  NoteData.h
//  BlocNotes
//
//  Created by Trevor Ahlert on 10/21/14.
//  Copyright (c) 2014 Trevor Ahlert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteData : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * title;

@end
