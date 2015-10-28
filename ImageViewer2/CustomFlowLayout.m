//
//  CustomFlowLayout.m
//  ImageViewer2
//
//  Created by Ni Yan on 10/28/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    int columnNumber = COLUMN_NUMBER;
    if (rect.size.width > 320)
    {
        columnNumber = COLUMN_NUMBER_MORE;
    }
    
    for (int i = 0; i < attributesArray.count; i++)
    {
        int totalHeight = 0;
        UICollectionViewLayoutAttributes * attributes = attributesArray[i];

        int rowNumber = i / columnNumber;
        
        //calculate the y position of the up-left corner
        for (int j = 0; j < rowNumber; j++)
        {
            UICollectionViewLayoutAttributes * verticalCellAttributes = attributesArray[j * columnNumber + i % columnNumber];
            totalHeight = totalHeight + verticalCellAttributes.frame.size.height;
        }

        attributes.frame = CGRectMake(attributes.frame.origin.x, totalHeight, attributes.frame.size.width, attributes.frame.size.height);
    }
    
    return attributesArray;
}

@end
