//
//  PJ_AddItemToCheckListViewController.h
//  cmypic
//
//  Created by Poojan Jhaveri on 6/28/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PJ_InputCompletionHandler)(NSString *inputText);
@interface PJ_AddItemToCheckListViewController : UIViewController<UITextFieldDelegate>


@property (copy, nonatomic) PJ_InputCompletionHandler completionHandler;
@end
