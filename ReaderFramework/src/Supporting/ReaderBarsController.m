//
//  ReaderBarsController.m
//	Reader v2.7.4
//
//  Created by Olesya Slepchenko on 29/06/15.
//
//

#import "ReaderBarsController.h"
#import "ReaderMainPagebar.h"

@interface ReaderBarsController ()

@property (nonatomic) BOOL originalStatusBarHidden;
@property (nonatomic) BOOL originalNavigationBarHidden;

@end

@implementation ReaderBarsController

@synthesize barsHidden = _barsHidden;

+ (ReaderBarsController*)barControllerWithPagebar:(ReaderMainPagebar*)pageBar
                             navigationController:(UINavigationController*)navigationController {
    ReaderBarsController * barController = [ReaderBarsController new];
    barController.pagebar = pageBar;
    barController.navigationController = navigationController;
    return barController;
}

-(void)setBarsHidden:(BOOL)barsHidden {
    [self setBarsHidden:barsHidden animation:ReaderBarsAnimationNone];
}

- (void)setBarsHidden:(BOOL)barsHidden animation:(ReaderBarsAnimation)animation {
    
    if(_barsHidden != barsHidden) {
        _barsHidden = barsHidden;
        
        if (self.barsHidden) {
            [self hideBarsWithAnimation:animation];
        }
        else {
            [self showBarsWithAnimation:animation];
        }
    }
}

- (void)hideBarsWithAnimation:(ReaderBarsAnimation)animation {
    
    self.originalStatusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    self.originalNavigationBarHidden = self.navigationController.navigationBarHidden;
    
    [self.pagebar hidePagebar];
    
    if (animation == ReaderBarsAnimationFade) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.navigationController.navigationBar setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }];
    }
    else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        [self.navigationController setNavigationBarHidden:YES];
    }
}

- (void)showBarsWithAnimation:(ReaderBarsAnimation)animation {
    
    [self.pagebar showPagebar];
    
    if (animation == ReaderBarsAnimationFade) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:self.originalStatusBarHidden
                                                withAnimation:UIStatusBarAnimationFade];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController setNavigationBarHidden:self.originalNavigationBarHidden animated:NO];
                [self.navigationController.navigationBar setAlpha:0.0f];
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self.navigationController.navigationBar setAlpha:1.0f];
                }];
            });
        });
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:self.originalStatusBarHidden
                                                withAnimation:UIStatusBarAnimationNone];
        [self.navigationController setNavigationBarHidden:self.originalNavigationBarHidden];
    }
}

@end
