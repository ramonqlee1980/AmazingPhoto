//
//  ViewController.h
//  CoreImage
//
//  Created by  on 11-11-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHYoukuMenuView.h"
#import "SHSShareViewController.h"

@interface SingleImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,HHYoukuMenuViewDelegate>
{
    HHYoukuMenuView *youkuMenuView;
    SHSShareViewController *shareController;
}
@property (nonatomic, retain) HHYoukuMenuView *youkuMenuView;

@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UISlider *slider2;
@property (strong, nonatomic) IBOutlet UISlider *slider3;

- (IBAction)changeValue:(id)sender;
- (IBAction)changeValue2:(id)sender;
- (IBAction)changeValue3:(id)sender;

- (IBAction)loadPhoto:(id)sender;
- (IBAction)savePhoto:(id)sender;
- (IBAction)resetImage:(id)sender;


-(id)initWithImage:(UIImage*)image;

@end
