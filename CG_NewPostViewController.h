//
//  CG_NewPostViewController.h
//  cmypic
//
//  Created by Chitvan Gupta on 28/06/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface CG_NewPostViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *postTextView;
@property (weak, nonatomic) IBOutlet UISwitch *postSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *postSegmentControl;

@property (strong, nonatomic) PFFile* photoName;
@property (strong, nonatomic) NSString *postMsg;
@property (assign,nonatomic) NSNumber *postIsTitle;
@property(strong,nonatomic)UIImage *imagerecieved;


- (IBAction)saveNewPost:(id)sender;
-(void)pickerCancel;
-(void)pickerDone;
@end
