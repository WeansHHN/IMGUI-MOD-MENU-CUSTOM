#import "Esp/ImGuiDrawView.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#include "IMGUI/imgui.h"
#include "IMGUI/imgui_impl_metal.h"
#import "Esp/CaptainHook.h"
#import "5Toubun/NakanoIchika.h"
#import "5Toubun/NakanoNino.h"
#import "5Toubun/NakanoMiku.h"
#import "5Toubun/NakanoYotsuba.h"
#import "5Toubun/NakanoItsuki.h"
#import "5Toubun/Obfuscate.h"
#import "zzz.h"
#import "Hook/dobby.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0 
#define g 0.86602540378444 

@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation ImGuiDrawView

static bool MenDeal = true;

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!_device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsClassic();
    
    ImFont* font = io.Fonts->AddFontFromMemoryCompressedTTF((void*)zzz_compressed_data, zzz_compressed_size, 50.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open {
    MenDeal = open;
}

- (MTKView *)mtkView {
    return (MTKView *)self.view;
}

- (void)loadView {
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}

#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event {
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches) {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled) {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    // Handle the drawable size change if needed
}

- (void)drawInMTKView:(MTKView*)view {
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1.0f / float(view.preferredFramesPerSecond ?: 120);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];

    static bool _isShowMenu = true;
    static int tab = 0;


    static bool show_s0 = false;    
    static bool show_s1 = false;    
    static bool show_s2 = false;    
    static bool show_s3 = false;    
    static bool show_s4 = false;    
    static bool show_s5 = false;    
    static bool show_s6 = false;                    
    static bool show_s7 = false;        
    static bool show_s8 = false;      
    static bool show_s9 = false;     
    static bool show_s10 = false;     
    static bool show_s11 = false;     
    static bool show_s12 = false;     

//Define active function
    static bool show_s0_active = false;
    static bool show_s1_active = false;
    static bool show_s2_active = false;

    float slider = 1.0;


    if (MenDeal == true) {
        [self.view setUserInteractionEnabled:YES];
    } else if (MenDeal == false) {
        [self.view setUserInteractionEnabled:NO];
    }

    MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil) {
        id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:@"ImGui Jane"];

        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
        ImGui::NewFrame();

        ImFont* font = ImGui::GetFont();
        font->Scale = 15.f / font->FontSize;

        CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
        CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 300) / 2;

        ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(380, 240), ImGuiCond_FirstUseEver);

        if (MenDeal == true) {
            ImGui::Begin("Weans(haininh.site)", &_isShowMenu, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize);

            ImGui::Columns(2);
            ImGui::SetColumnOffset(1, 120);

            ImGui::Spacing();
            if (ImGui::Button("Thông tin", ImVec2(100.0f, 40.0f))) {
                tab = 0;
            }
            ImGui::Spacing();
            if (ImGui::Button("Chức năng", ImVec2(100.0f, 40.0f))) {
                tab = 1;
            }
            ImGui::Spacing();
            if (ImGui::Button("Chức năng 2", ImVec2(100.0f, 40.0f))) {
                tab = 2;
            }

            ImGui::Spacing();
            ImGui::Text("        Made By");
            ImGui::Text("   HHN iOS(Weans)");

            ImGui::NextColumn();
            ImGui::BeginChild("##scroll1");

            switch (tab) {
                case 0:
                    ImGui::TextColored(ImColor(18, 140, 0), "#Text.");
                    ImGui::SliderFloat("Slider", &slider, 0, 20);
                    ImGui::Checkbox("CheckBox Button", &show_s1);
                    ImGui::SameLine();
                    if (ImGui::Button("Button")) {
                    }
                    break;

                case 1:
                    ImGui::Text("Tab1");
                    break;

                case 2:
                    ImGui::Text("Tab2");
                    break;
            }
            
            ImGui::EndChild();
            ImGui::End();
        }
        
        ImDrawList* draw_list = ImGui::GetBackgroundDrawList();
        ImGuiStyle& style = ImGui::GetStyle();
        ImVec4* colors = style.Colors;

        style.WindowRounding = 10.0f;
        style.WindowTitleAlign = ImVec2(0.5f, 0.5f);
        style.ChildRounding = 6.0f;
        style.PopupRounding = 6.0f;
        style.FrameRounding = 6.0f;
        style.FrameBorderSize = 1.0f;
        style.GrabRounding = 12.0f;
        style.TabRounding = 7.0f;
        style.ButtonTextAlign = ImVec2(0.5f, 0.5f);
        style.Alpha = 0.9f;

        if(show_s1){
                if(show_s1_active == NO){
                    patch("0x517A154", "0x360080D2");
                    patch_NULL("0x10517A154", "0x360080D2");
                    }
                show_s1_active = YES;
            }
            else{
                if(show_s1_active == YES){
                    patch("0x517A154", "0xF60302AA");
                    patch_NULL("0x10517A154", "0xF60302AA");
                    }
                show_s1_active = NO;
            }

        ImGui::Render();
        ImGui_ImplMetal_RenderDrawData(ImGui::GetDrawData(), commandBuffer, renderEncoder);
        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];
}

@end
