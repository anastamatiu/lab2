//
//  ViewController.m
//  Places
//
//  Created by iOS4 on 07/07/15.
//  Copyright (c) 2015 StamatiuAna. All rights reserved.
//

#import "ViewController.h"
#import "Profile.h"
#import "Settings.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *settingsView;

@property (strong, nonatomic) Profile *profile;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profile = [[Profile alloc] init];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:_firstNameTextField])
    {
        _firstNameLabel.textColor = [UIColor blackColor];
    }
    else  if([textField isEqual:_lastNameTextField])
    {
        _lastNameLabel.textColor = [UIColor blackColor];
    }
    return YES;
}

- (IBAction)dataUpdate:(UIDatePicker *)sender
{
    self.profile.birthday = sender.date;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if([textField isEqual:_firstNameTextField])
    {
        if([textField.text length] > 0)
            self.profile.firstName = textField.text;
        else
        {
            _firstNameLabel.textColor = [UIColor redColor];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No first name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        if([ textField.text length] > 0)
            self.profile.lastName = textField.text;
        else
        {
            _lastNameLabel.textColor = [UIColor redColor];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No last name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField isEqual:_firstNameTextField])
    {
        [_lastNameTextField becomeFirstResponder];
    }
    else
        [_lastNameTextField resignFirstResponder];
    
    return YES;
}

- (IBAction)buttonPressed:(UIButton *)sender {
    if(![sender isSelected])
    {
        if([sender isEqual:_profileButton])
        {
            [_profileView setHidden:NO];
            [_settingsView setHidden:YES];
            [_profileButton setSelected:YES];
            [_settingsButton setSelected:NO];
            
            
        }
        else if([sender isEqual:_settingsButton])
        {
            [_profileView setHidden:YES];
            [_settingsView setHidden:NO];
            [_profileButton setSelected:NO];
            [_settingsButton setSelected:YES];
           
        }
        
        [self updateIndicationViewWithDuration:0.2];
    }
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self updateIndicationViewWithDuration:0.0];
}

-(void) updateIndicationViewWithDuration:(CGFloat)duration {
    if([_profileButton isSelected])
    {
        _indicatorViewCenter.constant = 0;
    }
    else
    {
        _indicatorViewCenter.constant = - _settingsButton.frame.size.width;
    }
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
