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

#import "ObjCClass.h"
#import <objc/runtime.h>

@implementation ObjCClass

@synthesize name              = _name;
@synthesize class             = _class;
@synthesize protocols         = _protocols;
@synthesize instanceVariables = _instanceVariables;
@synthesize properties        = _properties;
@synthesize classMethods      = _classMethods;
@synthesize instanceMethods   = _instanceMethods;

+ ( NSArray * )allClasses
{
    int              numClasses;
    int              i;
    Class          * classes;
    NSMutableArray * classArray;
    ObjCClass      * class;
    
    numClasses = objc_getClassList( NULL, 0 );
    
    if( NULL == ( classes = ( Class * )malloc( sizeof( Class ) * ( unsigned int )numClasses ) ) )
    {
        return nil;
    }
    
    classArray = [ NSMutableArray arrayWithCapacity: ( NSUInteger )numClasses ];
    
    objc_getClassList( classes, numClasses );
    
    for( i = 0; i < numClasses; i++ )
    {
        class = [ [ ObjCClass alloc ] initWithClass: classes[ i ] ];
        
        [ classArray addObject: class ];
        [ class release ];
    }
    
    free( classes );
    
    [ classArray sortUsingComparator:
        ^( id obj1, id obj2 )
        {
            ObjCClass * class1;
            ObjCClass * class2;
            
            class1 = ( ObjCClass * )obj1;
            class2 = ( ObjCClass * )obj2;
            
            return [ class1.name caseInsensitiveCompare: class2.name ];
        }
    ];
    
    return [ NSArray arrayWithArray: classArray ];
}

+ ( NSArray * )allPublicClasses
{
    int              numClasses;
    int              i;
    Class          * classes;
    NSMutableArray * classArray;
    ObjCClass      * class;
    
    numClasses = objc_getClassList( NULL, 0 );
    
    if( NULL == ( classes = ( Class * )malloc( sizeof( Class ) * ( unsigned int )numClasses ) ) )
    {
        return nil;
    }
    
    classArray = [ NSMutableArray arrayWithCapacity: ( NSUInteger )numClasses ];
    
    objc_getClassList( classes, numClasses );
    
    for( i = 0; i < numClasses; i++ )
    {
        if( [ [ NSStringFromClass( classes[ i ] ) substringToIndex: 1 ] isEqualToString: @"_" ] )
        {
            continue;
        }
        
        class = [ [ ObjCClass alloc ] initWithClass: classes[ i ] ];
        
        [ classArray addObject: class ];
        [ class release ];
    }
    
    free( classes );
    
    [ classArray sortUsingComparator:
        ^( id obj1, id obj2 )
        {
            ObjCClass * class1;
            ObjCClass * class2;
            
            class1 = ( ObjCClass * )obj1;
            class2 = ( ObjCClass * )obj2;
            
            return [ class1.name caseInsensitiveCompare: class2.name ];
        }
    ];
    
    return [ NSArray arrayWithArray: classArray ];
}

- ( id )initWithClass: ( Class )class
{
    if( ( self = [ super init ] ) )
    {
        _name  = [ NSStringFromClass( class ) retain ];
        _class = class;
    }
    
    return self;
}

- ( void )dealloc
{
    [ _name release ];
    
    [ super dealloc ];
}

- ( NSString * )description
{
    NSString * description;
    
    description = [ super description ];
    
    return [ description stringByAppendingFormat: @" %@", _name ];
}

@end
