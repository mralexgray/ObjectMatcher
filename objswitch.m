//
//  ObjectMatcher.m
//
//  Created by Andy Lee on 4/7/13.
//  Copyright (c) 2013 Andy Lee. All rights reserved.
//

#import <AtoZUniversal/AtoZUniversal.h>

@interface ObjectMatcher ()
@property (nonatomic, strong) id baseObject;
@end

@implementation ObjectMatcher

+ objectMatcherSentinel { static ObjectMatcher *sentinel = nil;

  return dispatch_uno( sentinel = [self.alloc init]; ), sentinel;
}

+ matcherWithBaseObject:baseObj {

    return [self.alloc initWithBaseObject:baseObj];
}

- initWithBaseObject:baseObj {

  return self = super.init ? _baseObject = baseObj, self : nil;
}

- (BOOL)matchesAnyObject:(id)firstObject, ...
  {
    BOOL didMatch = NO;
    va_list args;
    va_start(args, firstObject);
    for (NSString *arg = firstObject; arg != [ObjectMatcher objectMatcherSentinel]; arg = va_arg(args, id))
    {
        if ([_baseObject isEqual:arg])
        {
            didMatch = YES;
        }
    }
    va_end(args);

    return didMatch;
}

- (BOOL)matchesAnyClass:(id)firstClass, ...
{
    BOOL didMatch = NO;
    va_list args;
    va_start(args, firstClass);
    for (Class arg = firstClass; arg != [ObjectMatcher objectMatcherSentinel]; arg = va_arg(args, Class))
    {
        if ([_baseObject isKindOfClass:arg])
        {
            didMatch = YES;
        }
    }
    va_end(args);

    return didMatch;
}

@end


@interface SelectorMatcher ()
@property (nonatomic) SEL baseSelector;
@end

@implementation SelectorMatcher

+ (SEL)selectorMatcherSentinel {

              static SEL sntnl4VarArgs;
    return dispatch_uno( sntnl4VarArgs = NSSelectorFromString(@"__SelectorMatcher__Sentinel__"); ),
                         sntnl4VarArgs;
}

+ matcherWithBaseSelector:(SEL)baseSel { return [self.alloc initWithBaseSelector:baseSel]; }

- initWithBaseSelector:(SEL)baseSel { return self = super.init ? _baseSelector = baseSel, self : nil; }

- (BOOL)matchesAnySelector:(SEL)firstSelector, ...
{
    BOOL didMatch = NO;
    va_list args;
    va_start(args, firstSelector);
    for (SEL arg = firstSelector; arg != [SelectorMatcher selectorMatcherSentinel]; arg = va_arg(args, SEL))
        if (_baseSelector == arg) didMatch = YES;
    va_end(args);
    return didMatch;
}

@end
