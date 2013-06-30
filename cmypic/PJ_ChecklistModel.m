//
//  PJ_ChecklistModel.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/26/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_ChecklistModel.h"
#import <Parse/Parse.h>

@implementation PJ_ChecklistModel

//Class Methods
+ (instancetype) sharedModel {
    static PJ_ChecklistModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}

// lazy load
- (NSMutableArray *) thingstodo {
    if (!_thingstodo) {
        
        _thingstodo = [[NSMutableArray alloc]
                       initWithObjects:@"Yes!", @"No", @"Maybe",
                       @"Can't decide", nil];
    }
    
    return _thingstodo;
}

- (NSUInteger) addAnswer: (NSString *)answerText {
    NSUInteger answerIndex = 0;
    [self.thingstodo insertObject:answerText
                          atIndex:answerIndex];
    [self savetoserver:answerText];
    return answerIndex;
}

-(void)savetoserver: (NSString *)itemtext
{
    NSLog(@"name is %@",itemtext);
    PFObject *Item=[PFObject objectWithClassName:@"CheckList"];
    [Item setObject:itemtext forKey:@"ListItem"];
    // [Item setObject:FALSE forKey:@"Completed"];
    [Item setObject:[PFUser currentUser] forKey:@"User"];
    [Item saveInBackground];
}


@end



