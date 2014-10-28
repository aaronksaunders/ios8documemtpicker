/**
 * ios8documemtpicker
 *
 * Created by aaron k saunders
 * Copyright (c) 2014 Your Company. All rights reserved.
 */

#import "ComCiIos8documemtpickerModule.h"
#import "TiBase.h"
#import "TiApp.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComCiIos8documemtpickerModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
    return @"5b0f9033-d3eb-4d01-a8f0-bb580f618220";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
    return @"com.ci.ios8documemtpicker";
}

#pragma mark Lifecycle

-(void)startup
{
    // this method is called when the module is first loaded
    // you *must* call the superclass
    [super startup];
    
    NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
    // this method is called when the module is being unloaded
    // typically this is during shutdown. make sure you don't do too
    // much processing here or the app will be quit forceably
    
    // you *must* call the superclass
    [super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
    // release any resources that have been retained by the module
    [super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
    // optionally release any resources that can be dynamically
    // reloaded once memory is available - such as caches
    [super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
    if (count == 1 && [type isEqualToString:@"my_event"])
    {
        // the first (of potentially many) listener is being added
        // for event named 'my_event'
    }
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
    if (count == 0 && [type isEqualToString:@"my_event"])
    {
        // the last listener called for event named 'my_event' has
        // been removed, we can optionally clean up any resources
        // since no body is listening at this point for that event
    }
}

#pragma Public APIs

-(id)example:(id)args
{
    // example method
    return @"hello world";
}

-(id)exampleProp
{
    // example property getter
    return @"hello world";
}

-(void)setExampleProp:(id)value
{
    // example property setter
}

-(void)openDocumentPicker:(id)value
{
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.image"]
        inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    UIViewController *rootController = [[[TiApp app] window] rootViewController];
    [rootController presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        
        NSLog(@"file path %@", [url path]);
        
        NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url lastPathComponent]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Import"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            
            UIViewController *rootController = [[[TiApp app] window] rootViewController];
            [rootController presentViewController:alertController animated:YES completion:nil];
        });
    }
}

/*
 *
 * Export Document Picker
 *
 */
- (void)openExportDocumentPicker:(id)sender {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc]
        initWithURL:[[NSBundle mainBundle]
        URLForResource:@"image" withExtension:@"jpg"]
        inMode:UIDocumentPickerModeExportToService];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    UIViewController *rootController = [[[TiApp app] window] rootViewController];
    [rootController presentViewController:documentPicker animated:YES completion:nil];
}

/*
 *
 * Cancelled
 *
 */
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    NSLog(@"Cancelled");
}

@end
