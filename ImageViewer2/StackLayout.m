//
//  StackLayout.m
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import "StackLayout.h"

@implementation StackLayout

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = [super collectionViewContentSize];
    
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes * attributes in attributesArray)
    {
        attributes.center = CGPointMake([_center_x intValue], [_center_y intValue]);
        
        //first image is on top, everything else is behind it
        attributes.zIndex = attributes.indexPath.row == 0 ? 1.0 : 0.0;
    }
    
    return attributesArray;
}


@end
