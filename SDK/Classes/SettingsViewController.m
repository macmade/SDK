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

#import "SettingsViewController.h"

static NSString * const __listCellID = @"ListCellID";

@implementation SettingsViewController

@synthesize tableView = _tableView;

- ( id )init
{
    if( ( self = [ self initWithNibName: @"Settings" bundle: nil ] ) )
    {}
    
    return self;
}

- ( void )dealloc
{
    [ super dealloc ];
}

- ( void )viewDidLoad
{
    [ super viewDidLoad ];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
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

- ( IBAction )close: ( id )sender
{
    ( void )sender;
    
    [ self dismissModalViewControllerAnimated: YES ];
}

- ( IBAction )showPrivateClasses: ( id )sender
{
    UISwitch * switchControl;
    
    switchControl = ( UISwitch * )sender;
    
    if( switchControl.isOn == YES )
    {
        [ [ NSUserDefaults standardUserDefaults ] setBool: YES forKey: @"ShowPrivateClasses" ];
    }
    else
    {
        [ [ NSUserDefaults standardUserDefaults ] setBool: NO forKey: @"ShowPrivateClasses" ];
    }
    
    [ [ NSUserDefaults standardUserDefaults ] synchronize ];
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
    
    return 1;
}

- ( UITableViewCell * )tableView: ( UITableView * )tableView cellForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    UISwitch        * switchControl;
    UITableViewCell * cell;
    
    ( void )indexPath;
    
    cell = [ tableView dequeueReusableCellWithIdentifier: __listCellID ];
    
    if( cell == nil )
    {
        cell = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: __listCellID ];
        
        [ cell autorelease ];
    }
    
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    cell.textLabel.text      = NSLocalizedString( @"ShowPrivateClasses", nil );
    cell.textLabel.textColor = [ UIColor colorWithHue: ( CGFloat )0.6 saturation: ( CGFloat )0.22 brightness: ( CGFloat )0.66 alpha: ( CGFloat )1 ];
    
    switchControl = [ [ UISwitch alloc ] initWithFrame: CGRectZero ];
    
    [ switchControl setOn: [ [ NSUserDefaults standardUserDefaults ] boolForKey: @"ShowPrivateClasses" ] ];
    [ switchControl addTarget: self action: @selector( showPrivateClasses: ) forControlEvents: UIControlEventValueChanged ];
    
    cell.accessoryView = switchControl;
    
    [ switchControl release ];
    
    return cell;
}

- ( void )tableView: ( UITableView * )tableView didSelectRowAtIndexPath: ( NSIndexPath * )indexPath
{
    ( void )tableView;
    ( void )indexPath;
}

@end
