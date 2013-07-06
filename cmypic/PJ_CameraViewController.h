//
//  PJ_CameraViewController.h
//  cmypic
//
//  Created by Poojan Jhaveri on 7/1/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PJ_CameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

@end
