//
//  ViewController.m
//  x-0
//
//  Created by Andrii Zykov on 9/8/15.
//  Copyright (c) 2015 AndriiZykov. All rights reserved.
//

#import "ViewController.h"
#import "GameCell.h"
@interface ViewController ()
@property (assign, nonatomic) BOOL isX;
@property (strong, nonatomic) NSMutableDictionary * WinnerArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    UIBarButtonItem * cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cencelAction:)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    [super viewDidLoad];
    
    self.WinnerArray = [NSMutableDictionary new];
    
    [self createField];
    
    self.isX = YES;
}

-(void) cencelAction:(UIBarButtonItem *) sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createField {
    
    CGFloat bigOffset = self.view.frame.size.height - self.view.frame.size.width;

    CGFloat smallOffset = 10.f;
    
    CGFloat fieldSize = self.view.frame.size.width - 20 ;
    
    CGRect fieldRect = CGRectMake(smallOffset , smallOffset + bigOffset / 2 , fieldSize , fieldSize );
    
    UIView * field = [[UIView alloc] initWithFrame:fieldRect];
    
    field.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:field];

    [self createLinesOnFieldView:field];
    
    [self getGameCellsOnView:field];
}

-(void) createLinesOnFieldView:(UIView *) view {
    
    UIView * rightHorizontal = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width / 3 - 5, 10, 10, view.frame.size.width - 20)];
    
    rightHorizontal.backgroundColor = [UIColor blackColor];
    
    [view addSubview:rightHorizontal];
    
    UIView * leftHorizontal = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width / 3 * 2 - 5, 10, 10, view.frame.size.width - 20)];
    
    leftHorizontal.backgroundColor = [UIColor blackColor];
    
    [view addSubview:leftHorizontal];
    
    
    UIView * upVertical = [[UIView alloc] initWithFrame:CGRectMake(10 , view.frame.size.width / 3 - 5 , view.frame.size.width - 20, 10)];
    
    upVertical.backgroundColor = [UIColor blackColor];
    
    [view addSubview:upVertical];
    
    UIView * downVertical = [[UIView alloc] initWithFrame:CGRectMake(10 , view.frame.size.width / 3 * 2 - 5 , view.frame.size.width - 20, 10)];
    
    downVertical.backgroundColor = [UIColor blackColor];
    
    [view addSubview:downVertical];
    
    
}

-(void) getGameCellsOnView:(UIView *) view {
    
    CGFloat cellSize = view.frame.size.height / 3;
    
    int count = 1;
    
    for ( int i = 0; i < 3;  i ++) {
        
        for (int j = 0; j < 3; j ++) {
            
            CGFloat jAddOffset = 5;
            
            CGFloat iAddOffset = 5;
            
            if (j > 0) {
                jAddOffset = 10;
            }
            
            if (i > 0) {
                iAddOffset = 10;
            }
            
            GameCell * cell = [[GameCell alloc] initWithFrame:CGRectMake(jAddOffset + cellSize * j, iAddOffset + cellSize * i, cellSize - 15, cellSize - 15)];
            
            cell.backgroundColor = [UIColor clearColor];
            
            [view addSubview:cell];
            
            cell.cellNumber = count;
            
            count++;
            
        }
        
     
        
    }
    
    
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch * touch in touches) {
        
        CGPoint point = [touch locationInView:self.view];
        
        UIView * cell = [self.view hitTest:point withEvent:nil];
        
        if ([cell isKindOfClass:[GameCell class]]) {
            
            GameCell * newCell = (GameCell *) cell;
            
            NSLog(@"%i", newCell.cellNumber);
            
            if (!newCell.isUsed) {
                
                newCell.isUsed = YES;
                
                newCell.isX = self.isX;
                
                [self.WinnerArray setObject: self.isX ? @"x" : @"0"  forKey:[NSString stringWithFormat:@"%i", newCell.cellNumber ]];
                
                self.isX = !self.isX;
                
                [newCell setNeedsDisplay];
                
                [self checkForWinner];
                
               
                
            } else {
                [[[UIAlertView alloc] initWithTitle:@"ATTENTION!!!" message:@"You Picked Used Cell" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil] show];
            }
            
        
        }
        
    }
    
}

-(void) checkForWinner {
    
//    NSLog(@"%@", self.WinnerArray);
    
    [self chechForWinForCells:@"1" andSecondCell:@"4" andThirdCell:@"7"];
    [self chechForWinForCells:@"2" andSecondCell:@"5" andThirdCell:@"8"];
    [self chechForWinForCells:@"3" andSecondCell:@"6" andThirdCell:@"9"];
    
    [self chechForWinForCells:@"1" andSecondCell:@"2" andThirdCell:@"3"];
    [self chechForWinForCells:@"4" andSecondCell:@"5" andThirdCell:@"6"];
    [self chechForWinForCells:@"7" andSecondCell:@"8" andThirdCell:@"9"];
    
    [self chechForWinForCells:@"1" andSecondCell:@"5" andThirdCell:@"9"];
    [self chechForWinForCells:@"3" andSecondCell:@"5" andThirdCell:@"7"];

}



-(void) chechForWinForCells:(NSString *) firstCell andSecondCell:(NSString *) secondCell andThirdCell:(NSString*) thirdCell{
    
    NSDictionary * td = [[NSDictionary alloc] initWithDictionary:self.WinnerArray];
    
    if ([[td objectForKey:firstCell] isEqualToString:[td objectForKey:secondCell]] && [[td objectForKey:firstCell] isEqualToString:[td objectForKey:thirdCell]]) {
        [self winOf:[td objectForKey:firstCell]];
    }
    
}

-(void) winOf:(NSString *) winner {
    
    NSString * player = nil;
    
    if ([winner isEqualToString:@"x"]) {
        player = @"1";
    } else {
        player = @"2";
    }
    
    NSString * message =[ NSString stringWithFormat:@"Player %@ win!", player];
    
    [[[UIAlertView alloc] initWithTitle:@"WIN!!!!" message:message delegate:nil cancelButtonTitle:@"NEW GAME" otherButtonTitles:nil] show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end




