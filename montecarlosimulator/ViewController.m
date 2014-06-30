//
//  ViewController.m
//  montecarlosimulator
//
//  Created by Yusuke Matsumura on 6/29/14.
//  Copyright (c) 2014 Yosemite Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    

    int width;
    int height;
    
    int centerx;
    int centery;
    
    float dotsize;
    
    
    NSInteger insideCount;
    NSInteger outsideCount;
    
    BOOL autoOn;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Projection setup
    _fieldView.layer.borderColor = [[UIColor blackColor] CGColor];
    CGRect rect = _fieldView.frame;
    width  = rect.size.width;
    height = rect.size.height;
    centerx = width/2;
    centery = height/2;
    insideCount=0;
    outsideCount=0;
    autoOn=NO;
    
    
    
    //Display setup (you can change here)
    dotsize = 6.0f;
    _fieldView.layer.borderWidth = 3;

    
    
    [self refreshStatLabel];
    
}

-(IBAction)resetPressed:(id)sender{
    [self reset];
}

-(void)reset{
    NSArray* ary = _fieldView.subviews;
    
    for(int i=0; i<ary.count; i++){
        UIView* v = (UIView*)ary[i];
        [v removeFromSuperview];
    }
    insideCount=0;
    outsideCount=0;
    [self refreshStatLabel];
}


-(IBAction)add1Point:(id)sender{
    [self addPoint];
}
-(IBAction)add10Point:(id)sender{
    
    
    for(int i=0; i<100; i++){
        [self addPoint];
    }
    
    
}

-(IBAction)autoPressed:(id)sender{
    autoOn = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        do {
            dispatch_sync(dispatch_get_main_queue(), ^{
                for(int i=0; i<1000; i++){
                    [self addPoint];
                }
            });
        } while (autoOn);
    });
}
-(IBAction)stopPressed:(id)sender{
    autoOn = NO;
}



- (void)addPoint{
    CGRect frame = CGRectMake(-dotsize/2, -dotsize/2, dotsize, dotsize);
    UIView* rectangle = [[UIView alloc] initWithFrame:frame];
    rectangle.center = [self randomPoint];
    float len = [self inoutJudge:rectangle.center];
    if(len<=0){
        //outside the circle
        rectangle.backgroundColor = [UIColor redColor];
        outsideCount++;
    }else{
        //inside the circle or on the boarder
        rectangle.backgroundColor = [UIColor blueColor];
        insideCount++;
    }
    [self refreshStatLabel];
    [_fieldView addSubview:rectangle];
}

-(void)refreshStatLabel{
    NSString *str = [NSString stringWithFormat:@"Total:%ld Inside:%ld PI=4*Inside/Total=%f",
                     insideCount+outsideCount, insideCount, 4.0f*insideCount/(insideCount+outsideCount) ];
    

    _statLabel.text = str;
}



- (float)inoutJudge:(CGPoint)point{
    float r = width/2.0f;
    float ax = fabs(point.x - centerx);
    float ay = fabs(point.y - centerx);
    float length = sqrt(pow(ax, 2.0) + pow(ay, 2.0));
    return r-length;
}


- (CGPoint)randomPoint{
    double x = random()/(RAND_MAX+0.0001) * width;
    double y = random()/(RAND_MAX+0.0001) * height;
    //return CGPointMake(x+dotsize/2,y+dotsize/2);
    return CGPointMake(x,y);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
