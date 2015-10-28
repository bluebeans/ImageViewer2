//
//  Utils.h
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define COLUMN_NUMBER 2
#define COLUMN_NUMBER_MORE 4

@interface Utils : NSObject

+(NSMutableArray *) getImages;
+ (UIImage *) getImageByUrl: (NSString *) url;
+ (void)addBorderToImage: (UIImageView *) imageView withColor: (UIColor *) color borderWidth: (float) width;
+ (NSInteger) findClosestCellIndex: (CGPoint) touchPoint to: (NSArray *) attributesArray;
@end
