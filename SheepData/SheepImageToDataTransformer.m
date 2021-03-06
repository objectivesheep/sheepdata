/* *****************************************************************
 *                     SheepData
 * -----------------------------------------------------------------
 
 Copyright (c) 2010, Fabio Russo
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of ObjectiveSheep CoreData nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL FABIO RUSSO BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 * ****************************************************************/

#import "SheepImageToDataTransformer.h"

@implementation SheepImageToDataTransformer

+ (BOOL)allowsReverseTransformation 
{
	return YES;
}

+ (Class)transformedValueClass 
{
	return [NSData class];
}

- (id)transformedValue:(id)value 
{
#if TARGET_OS_IPHONE
    return UIImagePNGRepresentation(value);
#else
    NSBitmapImageRep *rep = [[value representations] objectAtIndex: 0];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.7] forKey:NSImageCompressionFactor];
    NSData *data;
    @try
    {
        data = [rep representationUsingType:NSPNGFileType properties:imageProps];
//        data = [rep representationUsingType:NSJPEGFileType properties:imageProps];
    }
    @catch (id exception)
    {
        data = [value TIFFRepresentation];
    }
    return data;
#endif
}

- (id)reverseTransformedValue:(id)value 
{
#if TARGET_OS_IPHONE
    return [UIImage imageWithData:value];
#else
    return [[NSImage alloc] initWithData:value];
#endif
}

@end
