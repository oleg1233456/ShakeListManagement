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
#import "ZFTokenField.h"

@interface ViewController () <ZFTokenFieldDataSource, ZFTokenFieldDelegate>
@property (weak, nonatomic) IBOutlet ZFTokenField *tokenField;
@property (nonatomic, strong) NSMutableArray *tokens;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tokens = [NSMutableArray array];
    self.phraseArray = [NSMutableArray array];
    
    self.tokenField.dataSource = self;
    self.tokenField.delegate = self;
    self.shakeListTitleTextField.delegate = self;
    [self.tokenField reloadData];
    
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

- (void)tokenDeleteButtonPressed:(UIButton *)tokenButton
{
    NSUInteger index = [self.tokenField indexOfTokenView:tokenButton.superview];
    if (index != NSNotFound) {
        [self.tokens removeObjectAtIndex:index];
        [self.tokenField reloadData];
    }
}

- (IBAction)addPhraseTableCell:(id)sender {
    if (cellNumber > self.phraseArray.count) {
        return;
    }
    cellNumber++;
    NSLog(@"%ld", (long)cellNumber);
    
    [self.phraseTableView reloadData];
}

// Save and create a new shakelist.
- (IBAction)createNewShakeList:(id)sender {
    
    NSLog(@"title : %@", self.shakeListTitleTextField.text);                            // key
    NSLog(@"save type : %d", (int)self.listSaveTypeSegment.selectedSegmentIndex);       // key
    NSLog(@"NFSW Checked : %d", (int)nfsw_checked);                                     // key
    NSLog(@"G-RATED Checked : %d", (int)g_rated_checked);                               // key
    NSLog(@"Tag values : %@", self.tokens);                                             // array
    NSLog(@"Phrase Selection : %d", (int)self.phraseSelectionSegment.selectedSegmentIndex); // key
    NSLog(@"Phrase Array : %@", self.phraseArray);              // array

    NSMutableDictionary *shakeListData = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.shakeListTitleTextField.text, @"title", nil];
    [shakeListData setObject:[NSString stringWithFormat:@"%ld", self.listSaveTypeSegment.selectedSegmentIndex] forKey:@"type"];
    [shakeListData setObject:[NSString stringWithFormat:@"%d", (int)nfsw_checked] forKey:@"nfsw"];
    [shakeListData setObject:[NSString stringWithFormat:@"%d", (int)g_rated_checked] forKey:@"g-rated"];
    [shakeListData setObject:self.tokens forKey:@"tags"];
    [shakeListData setObject:[NSString stringWithFormat:@"%d", (int)self.phraseSelectionSegment.selectedSegmentIndex] forKey:@"phrase-selection"];
    [shakeListData setObject:self.phraseArray forKey:@"phrases"];
    
    // Connect to firebase.
    
    
    NSLog(@"shakelistdata result : \n %@", shakeListData);
    
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
    cell.phraseText.delegate = self;
    cell.phraseText.tag = indexPath.row;
    
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

#pragma mark UITextField data source

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"Textfield Tag : %d", textField.tag);

    if (textField.tag >= self.phraseArray.count) {
        [self.phraseArray addObject:textField.text];

    } else {
        [self.phraseArray replaceObjectAtIndex:textField.tag withObject:textField.text];
    }
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

#pragma mark - ZFTokenField DataSource

- (CGFloat)lineHeightForTokenInField:(ZFTokenField *)tokenField
{
    return 35;
}

- (NSUInteger)numberOfTokenInField:(ZFTokenField *)tokenField
{
    return self.tokens.count;
}

- (UIView *)tokenField:(ZFTokenField *)tokenField viewForTokenAtIndex:(NSUInteger)index
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"TokenView" owner:nil options:nil];
    UIView *view = nibContents[0];
    UILabel *label = (UILabel *)[view viewWithTag:2];
    UIButton *button = (UIButton *)[view viewWithTag:3];
    
    [button addTarget:self action:@selector(tokenDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    label.text = self.tokens[index];
    CGSize size = [label sizeThatFits:CGSizeMake(500, 35)];
    view.frame = CGRectMake(0, 0, size.width + 45, 35);
    return view;
}

#pragma mark - ZFTokenField Delegate

- (CGFloat)tokenMarginInTokenInField:(ZFTokenField *)tokenField
{
    return 5;
}

- (void)tokenField:(ZFTokenField *)tokenField didReturnWithText:(NSString *)text
{
    if (self.tokens.count < 4) {
        [self.tokens addObject:text];
    }
    
    [tokenField reloadData];
}

- (void)tokenField:(ZFTokenField *)tokenField didRemoveTokenAtIndex:(NSUInteger)index
{
    [self.tokens removeObjectAtIndex:index];
}

- (BOOL)tokenFieldShouldEndEditing:(ZFTokenField *)textField
{
    if (self.tokens.count >= 4) {
    }
    return YES;
}

@end
