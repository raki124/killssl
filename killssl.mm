#import <substrate.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>

static long (* __SSDebugLog)(int lv,NSString *format, ...);
static long HookedSSDebugLog(int lv,NSString *format, ...)
{
	NSString *newFormat = [[NSString alloc] initWithFormat:@"=======%@", format];
    va_list args;
    va_start(args, format);
    NSLogv(newFormat, args);
    va_end(args);
    return 0;
}

void InitKillSsl()
{
#if 1
	if(sizeof(long) != sizeof(int)){
		NSLog(@"=======kill ssl======= init 64");
		void *handle = dlopen("/System/Library/PrivateFrameworks/StoreServices.framework/StoreServices",RTLD_NOW);
		void * __SSDebugLogAddr = NULL;
		if (handle == NULL){
			NSLog(@"dlopen failed");
		}
		else{
			NSLog(@"dlopen suc");
			__SSDebugLogAddr = dlsym(handle,"SSDebugLog");
			dlclose(handle);
		}
		NSLog(@"__SSDebugLog = %p",__SSDebugLogAddr);
		if (__SSDebugLogAddr != NULL){
			 MSHookFunction((void *)(__SSDebugLogAddr),(void *)&HookedSSDebugLog,(void **)&__SSDebugLog);
	   		 NSLog(@"=======kill ssl======= init ok");
		}
	   
	}else{
		NSLog(@"=not support 32");
	}
#endif
}