//
//  ImageUICollectionViewController.m
//  ImageViewer2
//
//  Created by Ni Yan on 10/27/15.
//  Copyright © 2015 Ni Yan. All rights reserved.
//

#import "ImageUICollectionViewController.h"

@implementation ImageUICollectionViewController
{
    NSMutableArray * images;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.

    //style the collection view a bit
    [self styleCollectionView];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.88 green:0.96 blue:0.91 alpha:1.0];
    
    //get images from network, this could take time, should optimize
    images = [Utils getImages];
    
    //add pinch gesture handler
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchCollection:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    //listen to rotation event
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    if (images.count > 0)
    {
        UIImage * image = [images objectAtIndex: indexPath.row];
        UIImageView * cellImageView = [UIImageView new];
        
        //add border to the picture
        [Utils addBorderToImage: cellImageView withColor: [UIColor lightGrayColor] borderWidth: 2.0];


        if (image != nil)
        {
            [cellImageView setImage: image];

            //add drag and drop handler
            UIPanGestureRecognizer * dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
            [dragRecognizer setMinimumNumberOfTouches:1];
            [dragRecognizer setMaximumNumberOfTouches:1];
            [cellImageView addGestureRecognizer:dragRecognizer];
            
            cell.backgroundView = cellImageView;
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [images objectAtIndex:indexPath.row];

    //shrink the image to fit in screen
    float ratio = image.size.width / image.size.height;
    
    //fit different number of pictures depends on screen size
    int screenWidth = self.view.bounds.size.width;
    if (screenWidth <= 320) //an artificial number for iphone 5, change to be more general
    {
        return CGSizeMake((self.view.bounds.size.width - 30) / COLUMN_NUMBER, (self.view.bounds.size.width - 30) / (COLUMN_NUMBER * ratio));
    }
    else
    {
        return CGSizeMake((self.view.bounds.size.width - 60) / COLUMN_NUMBER_MORE, (self.view.bounds.size.width - 60) / (COLUMN_NUMBER_MORE * ratio));
    }
}

#pragma mark <Styling>
- (void) styleCollectionView
{
    CustomFlowLayout * layout = [[CustomFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    [layout setSectionInset :UIEdgeInsetsMake(10, 10, 10, 10)];
}

#pragma mark <Gesture Handling>
- (void) pinchCollection: (id)sender
{
    UIPinchGestureRecognizer * gesture = (UIPinchGestureRecognizer *) sender;
    
    if (gesture.scale >= 0 && gesture.scale < 1)
    {
        //pinch in
        
        //find out location of touches
        CGPoint firstTouchPoint = [sender locationOfTouch: 0 inView: self.collectionView];
        
        //find out to which cells are the touches next to
        NSInteger firstCell = [Utils findClosestCellIndex: firstTouchPoint to: [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect: self.view.bounds]];


        [self stackImages: firstCell];
    }
    else if (gesture.scale >= 1)
    {
        //pinch out
        [self expandImages];
    }
}

//stack images to center of the view
- (void) stackImages: (NSInteger) firstCell
{
    StackLayout * stackLayout = [[StackLayout alloc] init];
    stackLayout.center_x = [NSNumber numberWithInt: self.view.bounds.size.width / 2];
    stackLayout.center_y = [NSNumber numberWithInt: self.view.bounds.size.height / 2];
    stackLayout.firstCell = firstCell; //first finger (thumb usually) is closest to this cell

    
    self.collectionView.collectionViewLayout = stackLayout;

    [self.collectionView performBatchUpdates:^{
    } completion:nil];
}

//expand images back to normal
- (void) expandImages
{
    [self styleCollectionView];
    
    [self.collectionView performBatchUpdates:^{
    } completion:nil];
}

//started with drag and drop, in progress
- (void) moveImage: (id) sender
{
    CGPoint startPoint;
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        startPoint.x = [[sender view] center].x;
        startPoint.y = [[sender view] center].y;
    }
    
    CGPoint endPoint = CGPointMake(startPoint.x + translatedPoint.x, startPoint.y + translatedPoint.y);
    
    NSInteger dragFromItemIndex = [Utils findClosestCellIndex: startPoint to: [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect: self.view.bounds]];
    
    
    NSInteger dragToItemIndex = [Utils findClosestCellIndex: endPoint to: [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect: self.view.bounds]];
    
    
}

#pragma mark <Orientation Change>
-(void)OrientationDidChange:(NSNotification*)notification
{
    UIDeviceOrientation Orientation=[[UIDevice currentDevice]orientation];

    [self.collectionView reloadData];
    if(Orientation==UIDeviceOrientationLandscapeLeft || Orientation==UIDeviceOrientationLandscapeRight)
    {

    }
    else if(Orientation==UIDeviceOrientationPortrait)
    {
    }
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */
@end
