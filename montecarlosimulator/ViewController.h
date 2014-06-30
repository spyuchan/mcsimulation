//
//  ViewController.h
//  montecarlosimulator
//
//  Created by Yusuke Matsumura on 6/29/14.
//  Copyright (c) 2014 Yosemite Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView* fieldView;
@property (weak, nonatomic) IBOutlet UIButton* add1Button;
@property (weak, nonatomic) IBOutlet UIButton* add10Button;
@property (weak, nonatomic) IBOutlet UIButton* autoButton;
@property (weak, nonatomic) IBOutlet UIButton* stopButton;

@property (weak, nonatomic) IBOutlet UILabel* statLabel;


@end
