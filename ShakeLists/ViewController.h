//
//  ViewController.h
//  ShakeLists
//
//  Created by Software Superstar on 2/21/16.
//  Copyright © 2016 Software Superstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSInteger cellNumber;
    NSIndexPath* cellIndexPath;
    BOOL nfsw_checked;
    BOOL g_rated_checked;
}

@property (weak, nonatomic) IBOutlet UITableView *phraseTableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *shakeListTitleTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *listSaveTypeSegment;
@property (weak, nonatomic) IBOutlet UIButton *nfswCheckbox;
@property (weak, nonatomic) IBOutlet UIButton *gRatedCheckbox;

- (IBAction)addPhraseTableCell:(id)sender;
- (IBAction)createNewShakeList:(id)sender;
- (IBAction)nfswButtonClicked:(id)sender;
- (IBAction)gRatedButtonClicked:(id)sender;
- (IBAction)nfswCheckboxClicked:(id)sender;
- (IBAction)gRatedCheckboxClicked:(id)sender;

@end

