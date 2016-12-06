/*******************************************************************************
 * The MIT License (MIT)
 * 
 * Copyright (c) 2016 Jean-David Gadina - www-xs-labs.com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

#import "ClassesViewController.h"
#import "ObjCClass.h"

static NSString * const __listCellID = @"ListCellID";

@implementation ClassesViewController

- ( id )init
{
    if( ( self = [ self initWithNibName: @"ListView" bundle: nil ] ) )
    {
        if( [ [ NSUserDefaults standardUserDefaults ] boolForKey: @"ShowPrivateClasses" ] == YES )
        {
            _classes = [ [ ObjCClass allClasses ] retain ];
        }
        else
        {
            _classes = [ [ ObjCClass allPublicClasses ] retain ];
        }
    }
    
    return self;
}

- ( void )dealloc
{
    [ _classes release ];
    
    [ super dealloc ];
}

- ( void )viewDidLoad
{
    [ super viewDidLoad ];
    
    self.navigationItem.title = [ NSString stringWithFormat: NSLocalizedString( @"iOSVersion", nil ), [ [ UIDevice currentDevice ] systemVersion ] ];
    
    ( ( UITableView * )self.view ).delegate   = self;
    ( ( UITableView * )self.view ).dataSource = self;
}

- ( void )viewWillAppear: ( BOOL )animated
{
    [ super viewWillAppear: animated ];
}

- ( void )viewDidAppear: ( BOOL )animated
{
    [ super viewDidAppear: animated ];
}

- ( BOOL )shouldAutorotateToInterfaceOrientation: ( UIInterfaceOrientation )interfaceOrientation
{
    ( void )interfaceOrientation;
    
    return YES;
}

- ( NSInteger )numberOfSectionsInTableView: ( UITableView * )tableView
{
    ( void )tableView;
    
    return 1;
}

- ( NSInteger )tableView: ( UITableView * )tableView numberOfRowsInSection: ( NSInteger )section
{
    ( void )tableView;
    ( void )section;
    
    return ( NSInteger )[ _classes count ];
}

- ( UITableViewCell * )tableView: ( UITableView * )tableView cellForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    ObjCClass       * class;
    UITableViewCell * cell;
    
    ( void )indexPath;
    
    cell = [ tableView dequeueReusableCellWithIdentifier: __listCellID ];
    
    if( cell == nil )
    {
        cell = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: __listCellID ];
        
        cell.accessoryType       = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [ UIColor colorWithHue: ( CGFloat )0.6 saturation: ( CGFloat )0.22 brightness: ( CGFloat )0.66 alpha: ( CGFloat )1 ];
        cell.textLabel.font      = [ UIFont systemFontOfSize: [ UIFont systemFontSize ] ];
        
        [ cell autorelease ];
    }
    
    class               = ( ObjCClass * )[ _classes objectAtIndex: ( NSUInteger )[ indexPath row ] ];
    cell.textLabel.text = class.name;
    
    return cell;
}

- ( NSString * )tableView: ( UITableView * )tableView titleForHeaderInSection: ( NSInteger )section
{
    ( void )tableView;
    ( void )section;
    
    return NSLocalizedString( @"Classes", nil );
}

- ( void )tableView: ( UITableView * )tableView didSelectRowAtIndexPath: ( NSIndexPath * )indexPath
{
    ( void )tableView;
    ( void )indexPath;
}

@end
