//
//  ViewController.m
//  DawnTest
//
//  Created by 王文博 on 15/5/19.
//  Copyright (c) 2015年 王文博. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "RightViewController.h"

@interface ViewController ()
@property(nonatomic, strong) MainViewController *centerController;
@property(nonatomic, strong) RightViewController *rightController;
@property(nonatomic, strong) LeftViewController *leftController;
@property BOOL isMain;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _centerController = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    _leftController = (LeftViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    
    _rightController = (RightViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    
    [self.view addSubview:_centerController.view];
    [_centerController.view setTag:1];
    [_centerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_leftController.view];
    [_leftController.view setTag:2];
    [_leftController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_rightController.view];
    [_rightController.view setTag:3];
    [_rightController.view setFrame:self.view.bounds];
    
    [self.view bringSubviewToFront:_centerController.view];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_centerController.view addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_centerController.view addGestureRecognizer:swipeGestureLeft];
}

-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    
    //CALayer *layer = [_centerController.view layer];
    //layer.shadowColor = [UIColor blackColor].CGColor;
    //layer.shadowOffset = CGSizeMake(1, 1);
    //layer.shadowOpacity = 1;
    //layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [_leftController.view setHidden:NO];
        [_rightController.view setHidden:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == -100) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+100, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        
        [UIView commitAnimations];
    }
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [_rightController.view setHidden:NO];
        [_leftController.view setHidden:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == 100) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-100, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        
        [UIView commitAnimations];
    }
}

@end
