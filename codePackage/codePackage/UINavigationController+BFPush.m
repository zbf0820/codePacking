//
//  UINavigationController+BFPush.m
//  codePackage
//
//  Created by 周冰烽 on 2017/7/5.
//  Copyright © 2017年 周冰烽. All rights reserved.
//

#import "UINavigationController+BFPush.h"

@implementation UINavigationController (BFPush)
-(void)pushVC:(UIViewController *)vc animat:(BOOL)animate{
    if (self.childViewControllers>=0) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self pushViewController:vc animated:YES];
}
@end
