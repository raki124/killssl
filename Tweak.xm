#import "killssl.mm"

%group xx
%hook AuthenticateAttemptOperation

- (bool) _promptForCredentialsWithReason:(id)reason error:(id *)error
{
	NSLog(@"------------_promptForCredentialsWithReason enter %@",reason);
    bool ret = %orig(reason,error);
    NSLog(@"------------_promptForCredentialsWithReason %@ %@",ret ? @"true" : @"false",*error);
    return ret;
}
- (bool)_authKitPromptForCredentialsWithReason:(id)reason error:(id *)error
{
	NSLog(@"------------_authKitPromptForCredentialsWithReason enter %@",reason);
    bool ret = %orig(reason,error);
    NSLog(@"------------_authKitPromptForCredentialsWithReason %@ %@",ret ? @"true" : @"false",*error);
    return ret;
}

%end
%end

%ctor {
	%init(xx);
	InitKillSsl();
}
