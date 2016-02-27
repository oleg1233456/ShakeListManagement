//
//  SearchShakeListViewController.m
//  ShakeLists
//
//  Created by Software Superstar on 2/26/16.
//  Copyright © 2016 Software Superstar. All rights reserved.
//

#import "SearchShakeListViewController.h"

@interface SearchShakeListViewController ()

@end

@implementation SearchShakeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    rating_checked = NO;
    nfsw_checked = NO;
    g_rated_checked = NO;
    self.ratingView.hidden = YES;
    
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

- (IBAction)ratingCheckClicked:(id)sender {
    rating_checked = !rating_checked;
    
    if (rating_checked) {
        [self.ratingCheck setImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateNormal];
        self.ratingView.hidden = NO;
        
    } else {
        [self.ratingCheck setImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
        self.ratingView.hidden = YES;
    }
}

- (IBAction)nfswButtonClicked:(id)sender {
    nfsw_checked = !nfsw_checked;
    
    if (nfsw_checked) {
        [self.nfswCheck setImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateNormal];
        
    } else {
        [self.nfswCheck setImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)gRatedButtonClicked:(id)sender {
    g_rated_checked = !g_rated_checked;
    
    if (g_rated_checked) {
        [self.gRatedCheck setImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateNormal];
        
    } else {
        [self.gRatedCheck setImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - Phrase tabel view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

@end
