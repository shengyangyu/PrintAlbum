//
//  PAMainViewController.m
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-4.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import "PAMainViewController.h"
#import "PAEditorImageView.h"

@interface PAMainViewController ()

@end

@implementation PAMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    PAEditorImageView *vv = [[PAEditorImageView alloc] initWithFrame:CGRectMake(10, 20, 800, 800)];
    [self.view addSubview:vv];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //cell.center = self.view.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
