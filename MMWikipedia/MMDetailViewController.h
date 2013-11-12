//
//  MMDetailViewController.h
//  MMWikipedia
//
//  Created by Kyle Mai on 10/3/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NSString* (^AStringType) ();

@interface MMDetailViewController : UIViewController <UIWebViewDelegate>

//Interface outlets
@property (strong, nonatomic) IBOutlet UIWebView *wikiWebView;

//Properties
@property (strong, nonatomic) AStringType stringBlock;
@property (strong, nonatomic) NSString *wikiDetailTextString;
@property (strong, nonatomic) NSString *wikiItemTitle;

//Actions
- (IBAction)readMoreAction:(id)sender;

@end
