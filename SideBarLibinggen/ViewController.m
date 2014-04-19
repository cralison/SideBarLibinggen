//
//  ViewController.m
//  SideBarLibinggen
//
//  Created by LiBinggen on 14-4-19.
//  Copyright (c) 2014年 Libinggen. All rights reserved.
//

#import "ViewController.h"
#import "LeftSliderController.h"
#import "MainTableViewController.h"


@interface ViewController ()
{
    UIView *_leftSideView;
    UIView *_mainContentView;
    UITapGestureRecognizer *_tapGestureRec;
    UIPanGestureRecognizer *_panGestureRec;
    
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *lv = [[UIView alloc] initWithFrame:self.view.bounds];
    lv.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lv];
    _leftSideView = lv;
    
    UIView *mv = [[UIView alloc] initWithFrame:self.view.bounds];
    mv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:mv];
    _mainContentView = mv;
    
    LeftSliderController *leftSC = [[LeftSliderController alloc] init];
    [self addChildViewController:leftSC];
    [_leftSideView addSubview:leftSC.view];
    
    MainTableViewController *mainSC = [[MainTableViewController alloc] init];
    [self addChildViewController:mainSC];
    [_mainContentView addSubview:mainSC.tableView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    [self.view addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_mainContentView addGestureRecognizer:_panGestureRec];
    
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
    CGFloat transX;
    CGFloat transXC;
    if (panGes.state == UIGestureRecognizerStateBegan) {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        transX = [panGes translationInView:_mainContentView].x;
        transXC = transX + currentTranslateX;
        if (transXC < 0) {
            return;
        }
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transXC, 0);
        CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, 1.0);
        CGAffineTransform conT = CGAffineTransformConcat(scaleT,transT);
        _mainContentView.transform = conT;
    }else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        transX = [panGes translationInView:_mainContentView].x;
        transXC = transX + currentTranslateX;
        if (transX > 0) {
            if (transXC > 100) {
                CGAffineTransform transT = CGAffineTransformMakeTranslation(230, 0);
                CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, 1.0);
                CGAffineTransform conT = CGAffineTransformConcat(scaleT,transT);
                _mainContentView.transform = conT;
                _tapGestureRec.enabled = YES;
                return;
            }else
            {
                CGAffineTransform oriT = CGAffineTransformIdentity;
                [UIView beginAnimations:nil context:nil];
                _mainContentView.transform = oriT;
                _tapGestureRec.enabled = NO;
                return;
            }
        }
        if (transX < 0) {
            if (transXC < 130) {
                CGAffineTransform oriT = CGAffineTransformIdentity;
                [UIView beginAnimations:nil context:nil];
                _mainContentView.transform = oriT;
                _tapGestureRec.enabled = NO;
                return;
            }else
            {
                CGAffineTransform transT = CGAffineTransformMakeTranslation(230, 0);
                CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, 1.0);
                CGAffineTransform conT = CGAffineTransformConcat(scaleT,transT);
                _mainContentView.transform = conT;
                _tapGestureRec.enabled = YES;
                return;
            }
        }
    }
    
    
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    [UIView beginAnimations:nil context:nil];
    _mainContentView.transform = oriT;
    _tapGestureRec.enabled = NO;
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

