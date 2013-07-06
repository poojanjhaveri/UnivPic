//
//  PJ_AppDelegate.h
//  cmypic
//
//  Created by Poojan Jhaveri on 6/14/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PJ_ChecklistModel.h"

@interface PJ_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) PJ_ChecklistModel *model;
@end
