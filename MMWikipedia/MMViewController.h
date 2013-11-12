//
//  MMViewController.h
//  MMWikipedia
//
//  Created by Kyle Mai on 10/3/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

//Interface Outlets
@property (weak, nonatomic) IBOutlet UITableView *wikipediaTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *wikiSearchBar;

//Properties
@property (strong, nonatomic) UIActivityIndicatorView *spinning;
@property (strong, nonatomic) NSMutableArray *wikipediaResultArray;
@property (strong, nonatomic) NSString *searchQuery;
@property (strong, nonatomic) NSString *snippetString;
@property (strong, nonatomic) NSString *itemTitleString;

//Actions


@end
