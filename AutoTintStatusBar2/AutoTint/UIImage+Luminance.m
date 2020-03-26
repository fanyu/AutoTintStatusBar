//
//  UIImage+Luminance.m
//  AutoTintStatusBar2
//
//  Created by Yu Fan on 2020/3/26.
//  Copyright © 2020 edc. All rights reserved.
//

#import "UIImage+Luminance.h"
#import <objc/runtime.h>

@implementation UIImage (Luminance)

- (CGFloat)calculateAverageLuminance {
    if (!self) {
        return 0;
    }
    
    // 源图
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    // 滤镜的对象
    CIVector *extentVector = [CIVector vectorWithX:inputImage.extent.origin.x
                                                 Y:inputImage.extent.origin.y
                                                 Z:inputImage.extent.size.width
                                                 W:inputImage.extent.size.height];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIAreaAverage"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:extentVector forKey:kCIInputExtentKey];

    size_t rowBytes = 32;
    uint8_t byteBuffer[rowBytes];
    uint8_t *bitmap = &byteBuffer[0];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:@{kCIContextWorkingColorSpace: (id)kCFNull}];
    [context render:outputImage toBitmap:&bitmap rowBytes:4 bounds:CGRectMake(0, 0, 1, 1) format:kCIFormatRGBA8 colorSpace:nil];
    
    CGFloat r = bitmap[0] / 255;
    CGFloat g = bitmap[1] / 255;
    CGFloat b = bitmap[2] / 255;
    
    CGFloat luminance = 0.212 * r + 0.715 * g + 0.073 * b;
    
    return luminance;
}

@end
