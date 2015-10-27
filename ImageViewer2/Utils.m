//
//  Utils.m
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>

@implementation Utils

+ (UIImage *) getPictureByUrl: (NSString *) url
{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    
    UIImage * image;
    if (imageData.length > 0)
    {
        image = [UIImage imageWithData: imageData];
    }
    else
    {
        image = [UIImage imageNamed: @"placeholder.png"];
    }
    return image;
}

@end
