//
//  PJ_ChecklistModel.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/26/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_ChecklistModel.h"
#import <Parse/Parse.h>
#import "PJ_CheckListMainViewController.h"

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
        
        PFQuery *getquery =[PFQuery queryWithClassName:@"CheckList"];
        [getquery whereKey:@"User" equalTo:[PFUser currentUser]];
        [getquery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) 
        {
            if(!error)
            {
                _thingstodo=[[getquery getFirstObject] objectForKey:@"CheckListArray"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTableView" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshPickerView" object:nil];
            }
            else{
                
                _thingstodo=[[NSMutableArray alloc] initWithObjects: @"#FirstUSCFootballGame",nil];
               
                PFObject *Item=[PFObject objectWithClassName:@"CheckList" ];
                [Item addObject:@"#FirstUSCFootballGame" forKey:@"CheckListArray"];
                [Item setObject:[PFUser currentUser] forKey:@"User"];
                
                [Item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        //The registration was successful, go to the wall
                        NSLog(@"Checklist array successfully added for first time");
                    } else {
                        //Something bad has occurred
                        NSString *errorString = [[error userInfo] objectForKey:@"Please Check your connection. Unable to save the checklist array"];
                        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [errorAlertView show];
                    }
                }];
                
            }
            
        }];         
    }
    

    return _thingstodo;
}





- (NSUInteger) addAnswer: (NSString *)answerText {
    NSUInteger answerIndex = 0;
    answerText=[NSString stringWithFormat:@"#%@",answerText];
    [self.thingstodo insertObject:answerText
                          atIndex:answerIndex];
    [self savetoserver:answerText];
    return answerIndex;
}


-(void) deleteAnswer:(NSString *)deleteitem
{
    PFQuery *getquery =[PFQuery queryWithClassName:@"CheckList"];
    [getquery whereKey:@"User" equalTo:[PFUser currentUser]];
    [getquery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [object removeObject:deleteitem forKey:@"CheckListArray"];
        [object saveInBackground];
    }];
    
}


-(void)savetoserver: (NSString *)itemtext
{
    NSLog(@"name is %@",itemtext);
    
    
    PFQuery *getquery =[PFQuery queryWithClassName:@"CheckList"];
    [getquery whereKey:@"User" equalTo:[PFUser currentUser]];
    [getquery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error)
        {
            _myPFArray=object;
            [ _myPFArray addObject:itemtext forKey:@"CheckListArray"];
            [ _myPFArray saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    //The registration was successful, go to the wall
                    NSLog(@"Checklist array successfully added");
                } else {
                    //Something bad has occurred
                    NSString *errorString = [[error userInfo] objectForKey:@"Please Check your connection. Unable to save the checklist array"];
                    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorAlertView show];
                }
            }];

            
        }
    }];

    }


@end



