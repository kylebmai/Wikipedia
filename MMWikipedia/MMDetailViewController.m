//
//  MMDetailViewController.m
//  MMWikipedia
//
//  Created by Kyle Mai on 10/3/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMDetailViewController.h"

@interface MMDetailViewController ()

@end

@implementation MMDetailViewController
@synthesize stringBlock, wikiDetailTextString, wikiWebView, wikiItemTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = wikiItemTitle;
    wikiDetailTextString = stringBlock();
    [wikiWebView loadHTMLString:wikiDetailTextString baseURL:nil];
}

- (IBAction)readMoreAction:(id)sender
{
    
    NSString *stringToLoad = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", [wikiItemTitle stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    
    [wikiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringToLoad]]];
}
@end
