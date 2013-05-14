//
//  Tests.m
//  Tests
//
//  Created by Jonathan Crooke on 14/05/2013.
//  Copyright (c) 2013 Jon Crooke. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "TestPilot.h"
#import "Specta.h"
#import "UICollectionView+EmptyState.h"

#import "BlocksKit.h"

@interface SpecController1 : UICollectionViewController
@property (nonatomic, assign) NSUInteger numberOfSections;
@property (nonatomic, assign) NSUInteger numberOfSectionItems;
@end
@implementation SpecController1
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.numberOfSections;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
  return self.numberOfSectionItems;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return [collectionView dequeueReusableCellWithReuseIdentifier:@"Foo"
                                                   forIndexPath:indexPath];
}
@end

SpecBegin(Spec1);

describe(@"simple case", ^{

  __block SpecController1 *controller = nil;
  __block UICollectionViewFlowLayout *layout = nil;
  __block UIView *emptyView = nil;

  before(^{
    layout = [[UICollectionViewFlowLayout alloc] init];
    controller = [[SpecController1 alloc] initWithCollectionViewLayout:layout];

    controller.numberOfSectionItems = 10;
    controller.numberOfSections = 10;

    emptyView = [[UIView alloc] init];
    [controller loadView];
    expect(controller.isViewLoaded).to.beTruthy;
    expect(controller.collectionView).toNot.beNil;

    [controller.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"Foo"];

    controller.collectionView.emptyState_view = emptyView;
    [controller.collectionView reloadData];
    [controller.collectionView layoutSubviews];
  });
  after(^{
    controller = nil;
    layout = nil;
    emptyView = nil;
  });

  it(@"should not display overlay", ^{
    expect(emptyView.superview).toNot.equal(controller.collectionView);
  });

});

SpecEnd


