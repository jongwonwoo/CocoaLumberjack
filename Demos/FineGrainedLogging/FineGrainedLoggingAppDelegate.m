#import "FineGrainedLoggingAppDelegate.h"

#import "MYLog.h"
#import "DDContextFilterLogFormatter.h"

#import "TimerOne.h"
#import "TimerTwo.h"

// Debug levels: off, error, warn, info, verbose
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@implementation FineGrainedLoggingAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [DDLog addLogger:[DDASLLogger sharedInstance] withLevel:DDLogLevelVerbose | LOG_FLAG_TIMERS];
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelVerbose | LOG_FLAG_TIMERS];
    
    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? paths[0] : NSTemporaryDirectory();
    NSString *logsDirectory = [[basePath stringByAppendingPathComponent:@"Logs"] stringByAppendingPathComponent:appName];
    
    DDLogFileManagerDefault *fileManagerForFoodTimer = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[logsDirectory stringByAppendingPathComponent:@"FoodTimer"]];
    DDFileLogger *loggerForFoodTimer = [[DDFileLogger alloc] initWithLogFileManager:fileManagerForFoodTimer];
    DDContextWhitelistFilterLogFormatter *formatterForFoodTimer = [[DDContextWhitelistFilterLogFormatter alloc] init];
    [formatterForFoodTimer addToWhitelist:LOG_CONTEXT_FOOD_TIMER];
    [loggerForFoodTimer setLogFormatter:formatterForFoodTimer];
    [DDLog addLogger:loggerForFoodTimer withLevel:DDLogLevelVerbose | LOG_FLAG_TIMERS];
    
    DDLogFileManagerDefault *fileManagerForSleepTimer = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[logsDirectory stringByAppendingPathComponent:@"SleepTimer"]];
    DDFileLogger *loggerForSleepTimer = [[DDFileLogger alloc] initWithLogFileManager:fileManagerForSleepTimer];
    DDContextWhitelistFilterLogFormatter *formatterForSleepTimer = [[DDContextWhitelistFilterLogFormatter alloc] init];
    [formatterForSleepTimer addToWhitelist:LOG_CONTEXT_SLEEP_TIMER];
    [loggerForSleepTimer setLogFormatter:formatterForSleepTimer];
    [DDLog addLogger:loggerForSleepTimer withLevel:DDLogLevelVerbose | LOG_FLAG_TIMERS];
    
    timerOne = [[TimerOne alloc] init];
    timerTwo = [[TimerTwo alloc] init];
}

@end
