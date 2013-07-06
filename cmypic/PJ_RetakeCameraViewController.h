//
//  PJ_RetakeCameraViewController.h
//  cmypic
//
//  Created by Poojan Jhaveri on 7/4/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFImageEditorViewController.h"
#import "HFImageEditorViewController+SubclassingHooks.h"

// https://github.com/heitorfr/ios-image-editor

@interface PJ_RetakeCameraViewController : HFImageEditorViewController
{

}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy,nonatomic) UIImage *Image;

@end
