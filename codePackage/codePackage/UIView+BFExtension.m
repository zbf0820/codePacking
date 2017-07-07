//
//  UIView+BFExtension.m
//  codePackage
//
//  Created by 周冰烽 on 2017/7/7.
//  Copyright © 2017年 周冰烽. All rights reserved.
//

#import "UIView+BFExtension.h"

@implementation UIView (BFExtension)

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.size = size;
}
-(CGSize)size{
    return self.size;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.width = width;
}
-(CGFloat)width{
    return self.width;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.height = height;
}
-(CGFloat)height{
    return self.height;
}
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.x = x;
}
-(CGFloat)x{
    return self.x;
}
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.y = y;
}
-(CGFloat)y{
    return self.y;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.centerX = centerX;
}
-(CGFloat)centerX{
    return self.centerX;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.centerY = centerY;
}
-(CGFloat)centerY{
    return self.centerY;
}





@end
