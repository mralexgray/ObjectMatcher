# ObjectMatcher

[See here](http://www.notesfromandy.com/2013/04/07/faking-switch-with-an-object-value/) for a detailed explanation.

To use this stuff, copy these files into your project and import objswitch.h in your code.

You will then be able to do things like this:

<pre lang="objc">
objswitch(someObject)
objcase(@"one")
{
    // Nesting works.
    objswitch(@"b")
    objcase(@"a") printf("one/a");
    objcase(@"b") printf("one/b");
    endswitch

    // Any code can go here, including break/continue/return.
}
objcase(@"two") printf("It's TWO.");  // Can omit braces.
objcase(@"three",  // Can have multiple values in one case.
        nil,  // nil can be a "case" value.
        [self self],  // "Case" values don't have to be constants.
        @"tres",
        @"trois") { printf("It's a THREE."); }
defaultcase printf("None of the values above.");  // Optional default must be at end.
endswitch
</pre>

Or this:

<pre lang="objc">
objswitch(someObject)
objkind(NSNumber) { printf("It's a NUMBER."); }
objkind(NSString) { printf("It's a STRING."); }
objkind([NSArray class],
        [NSDictionary class],
        [NSSet class]) printf("It's a collection.");
endswitch
</pre>

Or this:

<pre lang="objc">
selswitch([anItem action])
selcase(@selector(selectSuperclass:))
{
    // ...
}
selcase(@selector(selectAncestorClass:))
{
    // ...
}
selcase(@selector(selectFormalProtocolsTopic:),
        @selector(selectInformalProtocolsTopic:),
        @selector(selectFunctionsTopic:))
{
    // ...
}
endswitch
</pre>


You can nest statements:

<pre lang="objc">
for (id ifNumericWhatIsIt in @[@99, @0, @"shnitzel"])
    objswitch(ifNumericWhatIsIt)
    objkind(NSNumber)  printf("It's a NUMBER.... "); 
        objswitch([ifNumericWhatIsIt stringValue])
            objcase(@"3")   printf("It's THREE.\n"); 
            objcase(@"99")  printf("It's NINETY-NINE.\n"); 
            defaultcase     printf("some other Number.\n");
       endswitch
    defaultcase printf("It's something else entirely.\n");
    endswitch
</pre>

> It's a NUMBER.... It's NINETY-NINE.

> It's a NUMBER.... some other Number.

> It's something else entirely.


