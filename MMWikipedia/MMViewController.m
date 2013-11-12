//
//  MMViewController.m
//  MMWikipedia
//
//  Created by Kyle Mai on 10/3/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMViewController.h"
#import "MMDetailViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController
@synthesize wikipediaResultArray, wikipediaTableView, wikiSearchBar, searchQuery, snippetString, itemTitleString, spinning;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Seach Wikipedia";
    wikipediaResultArray = [[NSMutableArray alloc] init];
    wikiSearchBar.showsCancelButton = YES;
    
    spinning = [[UIActivityIndicatorView alloc] initWithFrame:self.view.frame];
    [spinning setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinning.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchQuery = [wikiSearchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Adding spinning wheel of death
    [spinning startAnimating];
    [self.view addSubview:spinning];
    
    //Start getting contents from web
    NSString *searchString = [NSString stringWithFormat:@"https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=%@&srprop=snippet&format=json", searchQuery];
    
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSURLRequest *wikiRequest = [NSURLRequest requestWithURL:searchURL];
    [NSURLConnection sendAsynchronousRequest:wikiRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *dictionaryReturned = [[NSDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:&connectionError]];
        NSDictionary *objectOfKeyQuery = [[NSDictionary alloc] initWithDictionary:[dictionaryReturned objectForKey:@"query"]];
        NSArray *arrayOfbjectKeySearch = [[NSArray alloc] initWithArray:[objectOfKeyQuery objectForKey:@"search"]];
        wikipediaResultArray = arrayOfbjectKeySearch.mutableCopy;
        
        [wikipediaTableView reloadData];
        
        //remove spinning wheel
        [spinning stopAnimating];
        [spinning removeFromSuperview];
    }];
    
    [wikiSearchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    wikiSearchBar.text = searchQuery;
    [wikiSearchBar endEditing:YES];
    [wikiSearchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wikipediaResultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = [(NSDictionary *)[wikipediaResultArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    snippetString = [(NSDictionary *)[wikipediaResultArray objectAtIndex:indexPath.row] objectForKey:@"snippet"];
    itemTitleString = [(NSDictionary *)[wikipediaResultArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSLog(@"Dictionary: %@", [wikipediaResultArray objectAtIndex:indexPath.row]);
    [self performSegueWithIdentifier:@"segueToDetailViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MMDetailViewController *detailVC = segue.destinationViewController;
    detailVC.wikiItemTitle = itemTitleString;
    detailVC.stringBlock = ^(){
        return snippetString;
    };
}


@end
