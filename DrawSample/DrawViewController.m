//  Copyright (c) 2013年 KoheiKanagu. All rights reserved.

#import "DrawViewController.h"

@implementation DrawViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self becomeFirstResponder];

    [canvas setUserInteractionEnabled:YES];
    [self setPaintLineWidth:3];
    
    [segument setSelectedSegmentIndex:0];
    [segument addTarget:self
                 action:@selector(changeColor:)
       forControlEvents:UIControlEventValueChanged];
    [self changeColor:segument];
}


-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"shake Begin");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    canvas.image = nil;
    NSLog(@"shake End");
}

-(IBAction)cancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    NSLog(@"Cancel");
    canvas.image = nil;
}



#pragma mark -
#pragma mark Draw

-(void)changeColor:(UISegmentedControl *)seg
{
    switch(seg.selectedSegmentIndex){
        case 0: //black
            [self setPaintColorRed:0 Green:0 Blue:0 Alpha:1];
            break;
            
        case 1: //red
            [self setPaintColorRed:255 Green:0 Blue:0 Alpha:1];
            break;
            
        case 2: //blue
            [self setPaintColorRed:0 Green:0 Blue:255 Alpha:1];
            break;
            
        case 3: //yellow
            [self setPaintColorRed:255 Green:255 Blue:0 Alpha:1];
            break;
            
        case 4: //green
            [self setPaintColorRed:0 Green:255 Blue:0 Alpha:1];
            break;
    }
}

-(void)setPaintLineWidth:(float)w
{
    width = w;
}

-(void)setPaintColorRed:(int)r Green:(int)g Blue:(int)b Alpha:(float)a
{
    red = r;
    green = g;
    blue = b;
    alpha = a;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    oldMovePoint = [[touches anyObject] locationInView:canvas];
    
    UIGraphicsBeginImageContext(canvas.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), width);

    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint nowPoint = [[touches anyObject] locationInView:canvas];
    [canvas.image drawInRect:CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), oldMovePoint.x, oldMovePoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), nowPoint.x, nowPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    oldMovePoint = nowPoint;
    
    canvas.image = UIGraphicsGetImageFromCurrentImageContext();
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIGraphicsEndImageContext();
}




#pragma mark -
#pragma mark Save

-(IBAction)saveButton:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"確認", nil)
                                                message:NSLocalizedString(@"保存しますか？", nil)
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"いいえ", nil)
                                      otherButtonTitles:NSLocalizedString(@"はい", nil), nil];
    [av show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex){
              UIAlertView *av = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"確認", nil)
                                                    message:NSLocalizedString(@"保存完了", nil)
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"閉じる", nil)
                                          otherButtonTitles:nil, nil];
        [av show];
        
        [self cancelButton:nil];
    }
}



@end
