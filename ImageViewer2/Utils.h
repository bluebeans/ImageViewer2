//
//  Utils.h
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+(NSMutableArray *) getImages;
+ (UIImage *) getImageByUrl: (NSString *) url;
+ (void)addBorderToImage: (UIImageView *) imageView withColor: (UIColor *) color borderWidth: (float) width;
@end
