//
//  SearchShakeListViewController.h
//  ShakeLists
//
//  Created by Software Superstar on 2/26/16.
//  Copyright © 2016 Software Superstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchShakeListViewController : UIViewController {
    BOOL rating_checked;
    BOOL nfsw_checked;
    BOOL g_rated_checked;
}

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet UIView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *ratingCheck;
@property (weak, nonatomic) IBOutlet UIButton *nfswCheck;
@property (weak, nonatomic) IBOutlet UIButton *gRatedCheck;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

- (IBAction)ratingCheckClicked:(id)sender;
- (IBAction)nfswButtonClicked:(id)sender;
- (IBAction)gRatedButtonClicked:(id)sender;

@end
