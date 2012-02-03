/* *****************************************************************
 *                     ObjectiveSheep CoreData        
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

#import "FixturesContext.h"
#import "TestEntities.h"

@implementation FixturesContext

- (id)initWithContext:(NSManagedObjectContext*) aContext 
{
    self = [super init];
    if (self) 
    {
        ctx = aContext;
    }
    return self;
}

- (void) removeData
{
	NSArray * children = [Child fetchEntitiesInContext:ctx];
	for (Child * c in children)
	{
		[c deleteEntityInContext:ctx];
	}
	[Child saveContext:ctx];
	
	NSArray * fathers = [Father fetchEntitiesInContext:ctx];
	for (Father * c in fathers)
	{
		[c deleteEntityInContext:ctx];
	}
	[Father saveContext:ctx];
	
	NSArray * mothers = [Mother fetchEntitiesInContext:ctx];
	for (Mother * c in mothers)
	{
		[c deleteEntityInContext:ctx];
	}
	[Mother saveContext:ctx];
}

- (void) createData
{
	Father *f1 = [[Father alloc] initEntityInContext:ctx];
	f1.name = @"Father1";
	
	Mother *m1 = [[Mother alloc] initEntityInContext:ctx];
	m1.name = @"Mother1";
	
	Child *c1 = [[Child alloc] initEntityInContext:ctx];
	c1.name = @"Child1";
	c1.father = f1;
	c1.mother = m1;
	
	Child *c2 = [[Child alloc] initEntityInContext:ctx];
	c2.name = @"Child2";
	c2.father = f1;
	c2.mother = m1;
	
	Child *c3 = [[Child alloc] initEntityInContext:ctx];
	c3.name = @"Child3";
	c3.father = f1;
	c3.mother = m1;
	
	Child *c4 = [[Child alloc] initEntityInContext:ctx];
	c4.name = @"Child4";
	c4.father = f1;
	c4.mother = m1;
	
	[Father saveContext:ctx];
	
	Father *f2 = [[Father alloc] initEntityInContext:ctx];
	f2.name = @"Father2";
	
	Mother *m2 = [[Mother alloc] initEntityInContext:ctx];
	m2.name = @"Mother2";
	
	Child *c5 = [[Child alloc] initEntityInContext:ctx];
	c5.name = @"Child5";
	c5.father = f2;
	c5.mother = m2;
	[Father saveContext:ctx];
}

- (void) resetData
{
	[self removeData];
	[self createData];
}

@end
