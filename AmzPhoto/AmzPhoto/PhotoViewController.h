#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "MultiDialViewController.h"

@interface PhotoViewController : UIViewController<MultiDialViewControllerDelegate>
{
    GPUImageStillCamera *stillCamera;
    GPUImageOutput<GPUImageInput> *filter;
    UISlider *filterSettingsSlider;
    UIButton *photoCaptureButton;
    
    MultiDialViewController *multiDialController;
}

- (IBAction)updateSliderValue:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (void)spinToRandom:(id)sender;

@end
