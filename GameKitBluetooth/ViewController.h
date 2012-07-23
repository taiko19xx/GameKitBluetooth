//
//  ViewController.h
//  GameKitBluetooth
//
//  Created by 俊彦 木村 on 12/07/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <GKPeerPickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *sendTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
- (IBAction)tapSendButton:(id)sender;
- (IBAction)tapConnectButton:(id)sender;
- (IBAction)tapDisonnectButton:(id)sender;



@end
