//
//  MyShakeListViewController.h
//  ShakeLists
//
//  Created by Software Superstar on 2/23/16.
//  Copyright © 2016 Software Superstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShakeListViewController : UIViewController {
    
    NSInteger list_count;
}

@property (weak, nonatomic) IBOutlet UITableView *shakeListTableView;
@property (nonatomic, strong) NSMutableArray *listMutableArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (IBAction)testSetting:(id)sender;

@end
