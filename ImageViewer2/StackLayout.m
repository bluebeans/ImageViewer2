//
//  StackLayout.m
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import "StackLayout.h"

@implementation StackLayout


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes * attributes in attributesArray)
    {
        //display everything in the center
        attributes.center = CGPointMake([_center_x intValue], [_center_y intValue]);
        
        //first image is on top, everything else is at bottom
        attributes.zIndex = (attributes.indexPath.row == _firstCell ? 1.0 : 0.0);
    }
    
    return attributesArray;
}


@end
