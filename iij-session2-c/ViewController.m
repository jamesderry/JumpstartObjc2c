//
//  ViewController.m
//  iij-session2-c
//
//  Created by James Derry on 3/11/14.
//  Copyright (c) 2014 James Derry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *articles;  //to be an array of dictionaries
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //a free api from Pearson for Financial Times articles
    
    // ten articles downloaded by default
    NSString *articleUrl = @"https://api.pearson.com/v2/ft/articles";
    NSURL *url = [NSURL URLWithString:articleUrl];
    NSData *articleData = [NSData dataWithContentsOfURL:url];
    NSError *error;
    
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:articleData options:NSJSONReadingMutableContainers error:&error];
    
    articles = [NSMutableArray arrayWithArray:[parsedJSON objectForKey:@"results"]];
    
    NSLog(@"%@", articles);
}

#pragma mark - UITableView Delegate Methods


#pragma mark - UITableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"articleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *articleInfo = [articles objectAtIndex:indexPath.row];
    NSString *title = [articleInfo objectForKey:@"headline"];
    cell.textLabel.text = title;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
