//
//  ViewController.m
//  GameKitBluetooth
//
//  Created by 俊彦 木村 on 12/07/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    GKSession *currentSession;
}

@end

@implementation ViewController
@synthesize textView;
@synthesize sendTextView;
@synthesize sendButton;
@synthesize connectButton;
@synthesize disconnectButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [self setSendTextView:nil];
    [self setSendButton:nil];
    [self setConnectButton:nil];
    [self setDisconnectButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    [session setDataReceiveHandler:self withContext:nil];
    currentSession = session;
    
    NSLog(@"Connected!");
    
    picker.delegate = nil;
    [picker dismiss];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate = nil;
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    NSString* msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* text = [self.textView.text stringByAppendingFormat:@"\n%@", msg];
    self.textView.text = text;
}

- (IBAction)tapSendButton:(id)sender {
    NSString* msg = self.sendTextView.text;
	
	NSData* data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
	NSError* error = nil;
	[currentSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error];
    
	if (error) {
		NSLog(@"%@", error);
	}
	self.sendTextView.text = @"";
}

- (IBAction)tapConnectButton:(id)sender {
    GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby|GKPeerPickerConnectionTypeOnline;
    
    picker.delegate = self;
    [picker show];
}

- (IBAction)tapDisonnectButton:(id)sender {
    [currentSession disconnectFromAllPeers];
    [currentSession setDataReceiveHandler:nil withContext:nil];
}
@end
