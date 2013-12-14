//  Copyright (c) 2013年 KoheiKanagu. All rights reserved.

#import <UIKit/UIKit.h>

@interface DrawViewController : UIViewController <UINavigationBarDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIImageView *canvas;
    IBOutlet UISegmentedControl *segument;
    
    CGPoint oldMovePoint;
    int red, green, blue;
    float alpha;
    float width;
    
    CGContextRef context;
    CGPoint touchPoint;
}

-(IBAction)cancelButton:(id)sender;
-(IBAction)saveButton:(id)sender;


@end