//
//  PlacesTableTableViewController.m
//  Places
//
//  Created by iOS4 on 09/07/15.
//  Copyright (c) 2015 StamatiuAna. All rights reserved.
//

#import "PlacesTableTableViewController.h"
@import GoogleMaps;

@interface PlacesTableTableViewController ()

@property (strong, atomic) GMSPlacesClient *placesClient;
@property (strong, atomic) NSMutableDictionary *allPlaces;
@property (strong, nonatomic) NSMutableArray *letterArray;

@end

@implementation PlacesTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _placesClient = [[GMSPlacesClient alloc] init];
    
    _allPlaces = [[NSMutableDictionary alloc] init];
    
    _letterArray = [[NSMutableArray alloc] init];
    
        for(char a = 'a';a <= 'z';a++)
    {
        [_letterArray addObject:[NSString stringWithFormat:@"%c", a]];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    for(NSString *key in _letterArray)
    {
        [self placeAutocomplete:key];
    }
}

- (void)placeAutocomplete:(NSString *)key {
    
    CLLocationCoordinate2D left = CLLocationCoordinate2DMake(44.437714, 26.070900);
    CLLocationCoordinate2D right = CLLocationCoordinate2DMake(44.431278, 26.082401);
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:left
                                                                       coordinate:right];
    
    //GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    //filter.type = kGMSPlacesCityTypeFilter;
    
    [_placesClient autocompleteQuery:key
                              bounds:bounds
                              filter:nil
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                
                                for (GMSAutocompletePrediction* result in results) {
                                    NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                }
                            
                                [self.allPlaces setObject:results forKey:key];
                                [self.tableView reloadData];
                            }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [[self.allPlaces allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section
    return [[self.allPlaces objectForKey:[[self.allPlaces allKeys] objectAtIndex:section] ] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // Configure the cell...
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    

    GMSAutocompletePrediction *autocompletePrediction = [[self.allPlaces objectForKey:[self.letterArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
  //  NSString *string = [NSString stringWithFormat:@"section %lu, row %lu", indexPath.section, indexPath.row];
    
    cell.textLabel.text = autocompletePrediction.attributedFullText.string;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     GMSAutocompletePrediction *autocompletePrediction = [[self.allPlaces objectForKey:[self.letterArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSString *placeID = autocompletePrediction.placeID;
    
    [_placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            NSLog(@"Place name %@", place.name);
            NSLog(@"Place address %@", place.formattedAddress);
            NSLog(@"Place placeID %@", place.placeID);
            NSLog(@"Place attributions %@", place.attributions);
        } else {
            NSLog(@"No place details for %@", placeID);
        }
    }];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_letterArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
