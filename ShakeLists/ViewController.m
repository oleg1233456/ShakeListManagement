//
//  ViewController.m
//  ShakeLists
//
//  Created by Software Superstar on 2/21/16.
//  Copyright © 2016 Software Superstar. All rights reserved.
//

#import "ViewController.h"
#import "PhraseTableViewCell.h"
#import "MyShakeListViewController.h"
#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self.view bringSubviewToFront:self.phraseTableView];
    
    cellNumber = 1;
    nfsw_checked = NO;
    g_rated_checked = NO;
    
    Firebase *fb = [[Firebase alloc] initWithUrl:@"https://develop-shakelist.firebaseio.com/condition"];
    [fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        //        self.labelCondition.text = snapshot.value;
    }];
}

- (IBAction)sendFirst:(id)sender {
    Firebase *fb = [[Firebase alloc] initWithUrl:@"https://develop-shakelist.firebaseio.com/condition"];
    [fb setValue:@"first button"];
}

- (IBAction)sendSecond:(id)sender {
    Firebase *fb = [[Firebase alloc] initWithUrl:@"https://develop-shakelist.firebaseio.com/condition"];
    [fb setValue:@"second button"];
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
    return cellNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"Cell";
    
    PhraseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[PhraseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.positionLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UIScrollViewDecelerationRateFast];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        cellNumber--;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.phraseTableView reloadData];
    }
}

- (IBAction)addPhraseTableCell:(id)sender {
    cellNumber++;
    NSLog(@"%ld", (long)cellNumber);
    
    [self.phraseTableView reloadData];
}

// Save and create a new shakelist.
- (IBAction)createNewShakeList:(id)sender {
    
    NSLog(@"title : %@", self.shakeListTitleTextField.text);
    NSLog(@"save type : %d", (int)self.listSaveTypeSegment.selectedSegmentIndex);
    NSLog(@"NFSW Checked : %d", (int)nfsw_checked);
    NSLog(@"G-RATED Checked : %d", (int)g_rated_checked);
    
//    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShakeLIstController"];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)nfswButtonClicked:(id)sender {
   
    nfsw_checked = !nfsw_checked;
    [self setNFSWCheckboxImage:nfsw_checked];
}

- (IBAction)gRatedButtonClicked:(id)sender {
    
    g_rated_checked = !g_rated_checked;
    [self setGRatedCheckboxImage:g_rated_checked];
}

- (IBAction)nfswCheckboxClicked:(id)sender {
    
    nfsw_checked = !nfsw_checked;
    [self setNFSWCheckboxImage:nfsw_checked];
}

- (IBAction)gRatedCheckboxClicked:(id)sender {
    
    g_rated_checked = !g_rated_checked;
    [self setGRatedCheckboxImage:g_rated_checked];
}

#pragma mark checkbox image setting

- (void) setNFSWCheckboxImage:(BOOL) check_flag {

    NSString *imgNameStr;
    if (check_flag) {
        imgNameStr = @"checkbox_on.png";
        
    } else {
        imgNameStr = @"checkbox_off.png";
    }
    
    UIImage* btnImage = [UIImage imageNamed:imgNameStr];
    [self.nfswCheckbox setImage:btnImage forState:UIControlStateNormal];
}

-(void)setGRatedCheckboxImage:(BOOL) check_flag {
    
    NSString *imgNameStr;
    if (check_flag) {
        imgNameStr = @"checkbox_on.png";
        
    } else {
        imgNameStr = @"checkbox_off.png";
    }
    
    UIImage* btnImage = [UIImage imageNamed:imgNameStr];
    [self.gRatedCheckbox setImage:btnImage forState:UIControlStateNormal];
}

@end
