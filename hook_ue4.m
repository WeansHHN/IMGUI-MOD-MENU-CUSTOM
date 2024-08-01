//Quang Blue
//demo
//if you want hook aimbot pubgm
//get this in sdk dump: void SetControlRotation(struct FRotator& NewRotation, struct FString CallSource);// Offset: 0x1037fe374 // Return & Params: Num(2) Size(0x20)
//open ida go to 0x1037fe374 -> xref -> get offset from DCQ sub_xxxxx

//create hook:thiz(address have void you want hook)
//create struct FRotator same this in sdk
struct FRotator {
    float Pitch;
    float Yaw;
    float Roll;
};
//struct FString no need change can use void*
//shoot_root(this location bullet shoot to) can use for imvec3 or vector3 same value 1,2,3 FRotator
//
static void* (*orig_aimbot)(void* thiz, FRotator* NewRotation, void* CallSource);
static void* hook_aimbot(void* thiz, FRotator* NewRotation, void* CallSource){
    if(shoot_root.x !=0 && shoot_root.y !=0){
        NewRotation->Pitch = shoot_root.y;
        NewRotation->Yaw = shoot_root.x;
        NewRotation->Roll = 0;
    }
    //call orig void for new value
    return orig_aimbot(thiz,NewRotation,CallSource);
}

//active hook
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
  timer(5) {
        while(true){
          usleep(16666);
          auto addr_hook = your base addr + offset(line 5);
          if (*(void**)addr_hook != hook_aimbot) {
              orig_aimbot = decltype(orig_aimbot)(*(void**)addr_hook);
             *(void**)addr_hook = (void*)hook_aimbot;
          }
        }
      });     
}
%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}
//done
