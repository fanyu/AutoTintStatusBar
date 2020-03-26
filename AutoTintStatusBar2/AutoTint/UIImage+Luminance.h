//
//  UIImage+Luminance.h
//  AutoTintStatusBar2
//
//  Created by Yu Fan on 2020/3/26.
//  Copyright © 2020 edc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Luminance)
- (CGFloat)calculateAverageLuminance;
@end

NS_ASSUME_NONNULL_END
