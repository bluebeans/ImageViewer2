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
    self.collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];

    // Do any additional setup after loading the view.
    images = [NSMutableArray new];
    images = [Utils getImages];
    
    //add pinch gesture handler
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchCollection:)];
    [self.view addGestureRecognizer:pinchGesture];

    
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
    UIImage * image = [images  objectAtIndex: indexPath.row];
    UIImageView * cellImageView = [UIImageView new];

    [cellImageView setImage: image];
    cell.backgroundView = cellImageView;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [images objectAtIndex:indexPath.row];

    return CGSizeMake(image.size.width/5, image.size.height/5);
}

#pragma mark -- gesture handling
- (void) pinchCollection: (id)sender
{
    UIPinchGestureRecognizer * gesture = (UIPinchGestureRecognizer *) sender;
    
    if (gesture.scale >= 0 && gesture.scale < 1)
    {
        //pinch in
        [self stackImages];
    }
    else if (gesture.scale >= 1)
    {
        [self expandImages];
    }
}

- (void) stackImages
{
    StackLayout * stackLayout = [[StackLayout alloc] init];
    stackLayout.center_x = [NSNumber numberWithInt: self.view.bounds.size.width / 2];
    stackLayout.center_y = [NSNumber numberWithInt: self.view.bounds.size.height / 2];
    
    self.collectionView.collectionViewLayout = stackLayout;

    [self.collectionView performBatchUpdates:^{
    } completion:nil];
}

- (void) expandImages
{
    self.collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];

    [self.collectionView performBatchUpdates:^{
    } completion:nil];
    
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
