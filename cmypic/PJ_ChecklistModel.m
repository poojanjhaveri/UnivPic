//
//  PJ_ChecklistModel.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/26/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_ChecklistModel.h"

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


@end



