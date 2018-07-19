//
//  SortButton.m
//  takeOut
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "SortButton.h"

@implementation SortButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.titleLabel.textAlignment=NSTextAlignmentLeft;//Button内部的文字设置
        self.imageView.contentMode=UIViewContentModeLeft;//Button内部的图片设置居中
        self.titleLabel.numberOfLines=0;
        self.titleLabel.font=[UIFont systemFontOfSize:12.0];
    }
    return self;
}
//重新排列Button里面的图片和文字的位置(在一个Button里面显示文件和UIImage)
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageY,imageW,imageH,imageX;
    imageY=0;
    imageW=self.frame.size.height;
    imageH=self.frame.size.height;
    imageX=self.frame.size.width*0.85;
    return  CGRectMake(imageX, imageY, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX,titleY,titleW,titleH;
    titleX=0;
    titleY=0;
    titleW=self.frame.size.width*0.82;
    titleH=self.frame.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
