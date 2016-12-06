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

@interface ObjCClass: NSObject
{
@protected
    
    NSArray  * _protocols;
    NSArray  * _instanceVariables;
    NSArray  * _properties;
    NSArray  * _classMethods;
    NSArray  * _instanceMethods;
    NSString * _name;
    Class      _class;
    
@private
    
    id _ObjCClass_Reserved[ 5 ];
}

@property( atomic, readonly ) NSString * name;
@property( atomic, readonly ) Class      class;
@property( atomic, readonly ) NSArray  * protocols;
@property( atomic, readonly ) NSArray  * instanceVariables;
@property( atomic, readonly ) NSArray  * properties;
@property( atomic, readonly ) NSArray  * classMethods;
@property( atomic, readonly ) NSArray  * instanceMethods;

+ ( NSArray * )allClasses;
+ ( NSArray * )allPublicClasses;
- ( id )initWithClass: ( Class )class;

@end
