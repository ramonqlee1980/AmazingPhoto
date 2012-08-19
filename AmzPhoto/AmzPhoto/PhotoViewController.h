#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "CPPickerView.h"

@interface PhotoViewController : UIViewController<CPPickerViewDataSource, CPPickerViewDelegate>
{
    GPUImageStillCamera *stillCamera;
    GPUImageOutput<GPUImageInput> *filter;
    UISlider *filterSettingsSlider;
    UIButton *photoCaptureButton;
    
    CPPickerView *defaultPickerView;
    NSArray *daysData;
}

- (IBAction)updateSliderValue:(id)sender;
- (IBAction)takePhoto:(id)sender;

@end
