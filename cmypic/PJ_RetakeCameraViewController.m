//
//  PJ_RetakeCameraViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/4/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//


// https://github.com/heitorfr/ios-image-editor

#import "PJ_RetakeCameraViewController.h"
#import "CG_NewPostViewController.h"

@interface PJ_RetakeCameraViewController ()


@end

@implementation PJ_RetakeCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cropSize = CGSizeMake(300,300);
        self.minimumScale = 0.2;
        self.maximumScale = 10;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CG_NewPostViewController *viewController = ( CG_NewPostViewController *)[storyboard instantiateViewControllerWithIdentifier:@"NEWPOST"];

        self.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            viewController.imagerecieved=editedImage;
              [self.navigationController pushViewController:viewController animated:YES];
        };
        
        
    }
    return self;
}


- (IBAction)retakeButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
