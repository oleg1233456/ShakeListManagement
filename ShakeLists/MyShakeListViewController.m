//
//  MyShakeListViewController.m
//  ShakeLists
//
//  Created by Software Superstar on 2/23/16.
//  Copyright © 2016 Software Superstar. All rights reserved.
//

#import "MyShakeListViewController.h"
#import "ShakeListTableViewCell.h"
#import <Firebase/Firebase.h>

@interface MyShakeListViewController ()

@end

@implementation MyShakeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view bringSubviewToFront:self.shakeListTableView];
    self.loadingIndicator.hidden = NO;
    list_count = 0;
    
    // Get the sakelist data from the firebse.
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://develop-shakelist.firebaseio.com/shake-lists"];

    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        // do some stuff once
        NSLog(@"single result : %@", snapshot.value);
        self.listMutableArray = [NSMutableArray array];
        
        for ( FDataSnapshot *child in snapshot.children) {
            
            NSDictionary *dict = child.value; //or craft an object instead of dict
            
            [self.listMutableArray addObject:dict];
        }
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"author" ascending:YES]; //sort by date key, descending
        NSArray *arrayOfDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        [self.listMutableArray sortUsingDescriptors: arrayOfDescriptors];
        
        NSLog(@"result array : %@", self.listMutableArray);
        
        list_count = self.listMutableArray.count;
        self.loadingIndicator.hidden = YES;

        // Reload the shake list table.
        [self.shakeListTableView reloadData];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Phrase tabel view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list_count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"ListCell";
    
    ShakeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[ShakeListTableViewCell
                 alloc] initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.shakeImageView.image = [UIImage imageNamed:@"profile_icon.png"];
    cell.shakeImageView.layer.cornerRadius = 12;
    cell.shakeImageView.clipsToBounds = YES;
    cell.titleLabel.text = [[self.listMutableArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.userNameLabel.text = @"by You";
    NSMutableArray *phraseArray = [[self.listMutableArray objectAtIndex:indexPath.row] objectForKey:@"phrases"];
    NSInteger phrase_count = phraseArray.count;
    if (phraseArray == nil) {
        phrase_count = 0;
    }
    cell.phrasesCountLabel.text = [NSString stringWithFormat:@"%ld phrases", (long)phrase_count];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 800; // or any number based on your estimation
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)testSetting:(id)sender {
}
@end
