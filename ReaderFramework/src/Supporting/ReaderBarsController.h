//
//  ReaderBarsController.h
//	Reader v2.7.4
//
//  Created by Olesya Slepchenko on 29/06/15.
//
//

@class ReaderMainPagebar;

typedef NS_ENUM(NSUInteger, ReaderBarsAnimation) {
    ReaderBarsAnimationNone = 0,
    ReaderBarsAnimationFade
};

@interface ReaderBarsController : NSObject

@property (nonatomic) ReaderMainPagebar * pagebar;
@property (nonatomic) UINavigationController * navigationController;
@property (nonatomic) BOOL barsHidden;

+ (ReaderBarsController*)barControllerWithPagebar:(ReaderMainPagebar*)pageBar
                             navigationController:(UINavigationController*)navigationController;

- (void)setBarsHidden:(BOOL)barsHidden animation:(ReaderBarsAnimation)animation;

@end
