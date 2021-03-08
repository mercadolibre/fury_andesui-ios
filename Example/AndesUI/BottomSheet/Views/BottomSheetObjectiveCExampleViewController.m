//
//  BottomSheetObjectiveCExampleViewController.m
//  AndesUI-demoapp
//
//  Created by Tomi De Lucca on 29/10/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "BottomSheetObjectiveCExampleViewController.h"

#import <AndesUI/AndesUI-Swift.h>
#import "AndesUI_DemoApp-Swift.h"

@interface BottomSheetObjectiveCExampleViewController ()

@end

@implementation BottomSheetObjectiveCExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    self.title = @"BottomSheetObjectiveCExampleViewController";
    AndesButton* button = [[AndesButton alloc] initWithText:@"Open Andes Button Demo"
                                                  hierarchy:AndesButtonHierarchyLoud
                                                       size:AndesButtonSizeLarge
                                                       icon:nil];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self action:@selector(openSheet) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [[button topAnchor] constraintEqualToAnchor:[[[self view] layoutMarginsGuide] topAnchor] constant:16],
        [[button leftAnchor] constraintEqualToAnchor:[[self view] leftAnchor] constant:16],
        [[button rightAnchor] constraintEqualToAnchor:[[self view] rightAnchor] constant:-16]
    ]];
}

- (void)openSheet {
    AndesBottomSheetViewController* sheet = [[AndesBottomSheetViewController alloc] initWithRootViewController: [ButtonsViewController new]];
    [[sheet titleBar] setText:@"Andes Button Demo"];
    [[sheet titleBar] setTextAlignment:NSTextAlignmentLeft];
    [self presentViewController:sheet animated:YES completion:nil];
}

@end
