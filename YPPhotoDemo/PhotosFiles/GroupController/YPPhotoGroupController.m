//
//  YPPhotoGroupController.m
//  YPPhotoDemo
//
//  Created by YueWen on 16/7/13.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import "YPPhotoGroupController.h"
#import "YPPhotoGroupCell.h"
#import "PHObject+SupportCategory.h"
#import "YPPhotosController.h"


@interface YPPhotoGroupController ()<YPPhotosControllerDelegate>

@property (nonatomic, strong) YPPhotoStore * photoStore;
@property (nonatomic, strong) NSArray<PHAssetCollection *> * groups;
@property (nonatomic, strong) NSNumber * maxNumberOfSelectImages;

@end

@implementation YPPhotoGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[YPPhotoGroupCell class] forCellReuseIdentifier:@"YPPhotoGroupCell"];
    
    //Navigation
    self.navigationItem.title = @"相册";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancle" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidTap)];
    
    
    __weak typeof(self)copy_self = self;
    
    self.photoStore = [[YPPhotoStore alloc]init];
    
    //获取默认的相片组
    [self.photoStore fetchDefaultAllPhotosGroup:^(NSArray<PHAssetCollection *> * _Nonnull groups) {

        copy_self.groups = groups;
        [copy_self pushPhotosViewController:[NSIndexPath indexPathForRow:0 inSection:0] Animate:false];
        [copy_self.tableView reloadData];
        
    }];
}

- (IBAction)cancleItemButtonDidTap:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    self.groups = nil;
#ifdef YDEBUG
    NSLog(@"YPPhotoGroupController Dealloc");
#endif
}


- (void)rightBarButtonItemDidTap
{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YPPhotoGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YPPhotoGroupCell class]) forIndexPath:indexPath];
    
    // Configure the cell...
    PHAssetCollection * collection = [self.groups objectAtIndex:indexPath.row];

    [collection representationImageWithSize:CGSizeMake(60, 60) complete:^(NSString * _Nonnull title, NSUInteger estimatedCount, UIImage * _Nullable image) {
       
        NSString * localTitle = NSLocalizedString(title, @"");
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",localTitle,@(estimatedCount)];
        cell.imageView.image = image;
        
    }];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除选择痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    [self pushPhotosViewController:indexPath Animate:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - <YPPhotosControllerDelegate>
-(void)photosController:(YPPhotosController *)viewController photosSelected:(nonnull NSArray<PHAsset *> *)assets Status:(nonnull NSArray<NSNumber *> *)status
{
    self.photosDidSelectBlock(assets,status);
}

-(void)photosControllerShouldBack:(YPPhotosController *)viewController
{
    [self dismissViewControllerAnimated:true completion:^{}];
}


#pragma mark - push photosviewcontroller
- (void)pushPhotosViewController:(NSIndexPath *)indexPath Animate:(BOOL)animate
{
    YPPhotosController * collectionViewController = [[YPPhotosController alloc]init];
    
    //传递组对象
    [collectionViewController setValue:[self.photoStore fetchPhotos:self.groups[indexPath.row]] forKey:@"assets"];
    [collectionViewController setValue:self.groups[indexPath.row].localizedTitle forKey:@"itemTitle"];
    [collectionViewController setValue:self.maxNumberOfSelectImages forKey:@"maxNumberOfSelectImages"];
    
    collectionViewController.delegate = self;
    
    [self.navigationController pushViewController:collectionViewController animated:animate];
}



@end
