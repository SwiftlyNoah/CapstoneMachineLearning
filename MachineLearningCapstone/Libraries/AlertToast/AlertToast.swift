//
//  AlertToast.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/24/21.
//

import SwiftUI

struct AlertToast: View {
    
    /// Determine how the alert will be display
    public enum DisplayMode: Equatable {
        
        ///Present at the center of the screen
        case alert
        
        ///Drop from the top of the screen
        case hud
    }
    
    /// Determine what the alert will display
    public enum AlertType: Equatable{
        ///System image from `SFSymbols`
        case systemImage(_ name: String, _ color: Color)
        
        ///Image from Assets
        case image(_ name: String, _ color: Color)
        
        ///Loading indicator (Circular)
        case loading
        
        ///Only text alert
        case regular
    }
    
    /// Customize Alert Appearance
    public enum AlertCustom: Equatable {
        case custom(backgroundColor: Color? = nil,
                    titleColor: Color? = nil,
                    subTitleColor: Color? = nil,
                    titleFont: Font? = nil,
                    subTitleFont: Font? = nil)
        
        ///Get background color
        var backgroundColor: Color? {
            switch self {
            case .custom(backgroundColor: let color, _, _, _, _):
                return color
            }
        }
        
        /// Get title color
        var titleColor: Color? {
            switch self{
            case .custom(_,let color, _,_,_):
                return color
            }
        }
        
        /// Get subTitle color
        var subtitleColor: Color? {
            switch self{
            case .custom(_,_, let color, _,_):
                return color
            }
        }
        
        /// Get title font
        var titleFont: Font? {
            switch self {
            case .custom(_, _, _, titleFont: let font, _):
                return font
            }
        }
        
        /// Get subTitle font
        var subTitleFont: Font? {
            switch self {
            case .custom(_, _, _, _, subTitleFont: let font):
                return font
            }
        }
    }
    
    ///The display mode
    ///`.alert`
    ///`.hud`
    public var displayMode: DisplayMode = .alert
    
    ///What the alert would show
    ///`systemImage`, `image`, `loading`, `regular`
    public var type: AlertType
    
    ///The title of the alert (`Optional(String)`)
    public var title: String? = nil
    
    ///The subtitle of the alert (`Optional(String)`)
    public var subTitle: String? = nil
    
    ///Customize your alert appearance
    public var custom: AlertCustom?
    
    ///Full init
    public init(displayMode: DisplayMode = .alert,
                type: AlertType,
                title: String? = nil,
                subTitle: String? = nil,
                custom: AlertCustom? = nil){
        
        self.displayMode = displayMode
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.custom = custom
    }
    
    ///Short init with most used parameters
    public init(displayMode: DisplayMode,
                type: AlertType,
                title: String? = nil){
        
        self.displayMode = displayMode
        self.type = type
        self.title = title
    }
    
    ///HUD View
    public var hud: some View {
        Group{
            HStack(spacing: 16){
                switch type {
                case .systemImage(let name, let color):
                    Image(systemName: name)
                        .hudModifier()
                        .foregroundColor(color)
                case .image(let name, let color):
                    Image(name)
                        .hudModifier()
                        .foregroundColor(color)
                case .loading:
                    ActivityIndicator()
                case .regular:
                    EmptyView()
                }
                
                if title != nil || subTitle != nil{
                    VStack(alignment: type == .regular ? .center : .leading, spacing: 2){
                        if title != nil{
                            Text(LocalizedStringKey(title ?? ""))
                                .font(custom?.titleFont ?? Font.body.bold())
                                .multilineTextAlignment(.center)
                                .textColor(custom?.titleColor ?? nil)
                        }
                        if subTitle != nil{
                            Text(LocalizedStringKey(subTitle ?? ""))
                                .font(custom?.subTitleFont ?? Font.footnote)
                                .opacity(0.7)
                                .multilineTextAlignment(.center)
                                .textColor(custom?.subtitleColor ?? nil)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .frame(minHeight: 55)
            .alertBackground(custom?.backgroundColor ?? nil)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.gray.opacity(0.2), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 6)
            .compositingGroup()
        }
        .padding(.top)
    }
    
    ///Alert View
    public var alert: some View {
        VStack(spacing: 0) {
            switch type{
            case .systemImage(let name, let color):
                Spacer()
                Image(systemName: name)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .foregroundColor(color)
                Spacer()
            case .image(let name, let color):
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .foregroundColor(color)
                    .padding(.top)
            case .loading:
                ActivityIndicator()
            case .regular:
                EmptyView()
            }
            
            VStack(spacing: type == .regular ? 8 : 2){
                if title != nil{
                    Text(LocalizedStringKey(title ?? ""))
                        .font(custom?.titleFont ?? Font.body.bold())
                        .multilineTextAlignment(.center)
                        .textColor(custom?.titleColor ?? nil)
                        .padding(.bottom, 35)
                        .offset(y: -10)
                }
                if subTitle != nil{
                    Text(LocalizedStringKey(subTitle ?? ""))
                        .font(custom?.subTitleFont ?? Font.footnote)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                        .textColor(custom?.subtitleColor ?? nil)
                }
            }
        }
        .withFrame(type != .regular && type != .loading)
        .alertBackground(custom?.backgroundColor ?? nil)
        .cornerRadius(10)
    }
    
    ///Body init determine by `displayMode`
    public var body: some View {
        switch displayMode{
        case .alert:
            alert
        case .hud:
            hud
        }
    }
}

public struct AlertToastModifier: ViewModifier {
    
    ///Presentation `Binding<Bool>`
    @Binding var isPresenting: Bool
    
    ///Duration time to display the alert
    @State var duration: Double = 2
    
    ///Tap to dismiss alert
    @State var tapToDismiss: Bool = true
    
    ///Init `AlertToast` View
    var alert: () -> AlertToast
    
    ///Completion block returns `true` after dismiss
    var completion: ((Bool) -> ())? = nil
    
    @State private var hostRect: CGRect = .zero
    @State private var alertRect: CGRect = .zero
    
    private var offset: CGFloat{
        return -hostRect.midY + alertRect.height
    }
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader{ geo -> AnyView in
                    let rect = geo.frame(in: .global)
                    
                    if rect.integral != hostRect.integral{
                        DispatchQueue.main.async {
                            self.hostRect = rect
                        }
                    }
                    
                    return AnyView(EmptyView())
                }
                .overlay(ZStack{
                    if isPresenting{
                        
                        switch alert().displayMode{
                        case .alert:
                            alert()
                                .onAppear {
                                    
                                    if alert().type == .loading{
                                        duration = 0
                                        tapToDismiss = false
                                    }
                                    
                                    if duration > 0{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                            withAnimation(.spring()){
                                                isPresenting = false
                                            }
                                        }
                                    }
                                }
                                .onTapGesture {
                                    if tapToDismiss{
                                        withAnimation(.spring()){
                                            isPresenting = false
                                        }
                                    }
                                }
                                .onDisappear {
                                    completion?(true)
                                }
                                .transition(AnyTransition.scale(scale: 0.8).combined(with: .opacity))
                        case .hud:
                            alert()
                                .overlay(
                                    GeometryReader{ geo -> AnyView in
                                        let rect = geo.frame(in: .global)
                                        
                                        if rect.integral != alertRect.integral{
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.alertRect = rect
                                            }
                                        }
                                        return AnyView(EmptyView())
                                    }
                                )
                                .onAppear {
                                    
                                    if alert().type == .loading{
                                        duration = 0
                                        tapToDismiss = false
                                    }
                                    
                                    if duration > 0{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                            withAnimation(.spring()){
                                                isPresenting = false
                                            }
                                        }
                                    }
                                }
                                .onTapGesture {
                                    if tapToDismiss{
                                        withAnimation(.spring()){
                                            isPresenting = false
                                        }
                                    }
                                }
                                .onDisappear {
                                    completion?(true)
                                }
                                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: alert().displayMode == .alert ? .infinity : -hostRect.midY / 2, alignment: .center)
                .offset(x: 0, y: alert().displayMode == .alert ? 0 : offset)
                .edgesIgnoringSafeArea(alert().displayMode == .alert ? .all : .bottom)
                .animation(.spring()))
            )
        
    }
}

///Fileprivate View Modifier for dynamic frame when alert type is `.regular` / `.loading`
fileprivate struct WithFrameModifier: ViewModifier{
    var withFrame: Bool
    
    var maxWidth: CGFloat = 175
    var maxHeight: CGFloat = 175
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if withFrame {
            content
                .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .center)
        }
        else {
            content
        }
    }
}

///Fileprivate View Modifier to change the alert background
fileprivate struct BackgroundModifier: ViewModifier {
    var color: Color?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if color != nil {
            content
                .background(color)
        }
        else {
            content
                .background(BlurView())
        }
    }
}

///Fileprivate View Modifier to change the text colors
fileprivate struct TextForegroundModifier: ViewModifier {
    var color: Color?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if color != nil {
            content
                .foregroundColor(color)
        }
        else {
            content
        }
    }
}

fileprivate extension Image {
    func hudModifier() -> some View {
        self
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
    }
}

public extension View {
    
    /// Return some view w/o frame depends on the condition.
    /// This view modifier function is set by default to:
    /// - `maxWidth`: 175
    /// - `maxHeight`: 175
    fileprivate func withFrame(_ withFrame: Bool) -> some View{
        modifier(WithFrameModifier(withFrame: withFrame))
    }
    
    /// Present `AlertToast`.
    /// - Parameters:
    ///   - show: Binding<Bool>
    ///   - alert: () -> AlertToast
    /// - Returns: `AlertToast`
    internal func toast(isPresenting: Binding<Bool>, duration: Double = 2, tapToDismiss: Bool = true, alert: @escaping () -> AlertToast, completion: ((Bool) -> ())? = nil) -> some View {
        modifier(AlertToastModifier(isPresenting: isPresenting, duration: duration, tapToDismiss: tapToDismiss, alert: alert, completion: completion))
    }
    
    /// Choose the alert background
    /// - Parameter color: Some Color, if `nil` return `VisualEffectBlur`
    /// - Returns: some View
    fileprivate func alertBackground(_ color: Color? = nil) -> some View{
        modifier(BackgroundModifier(color: color))
    }
    
    /// Choose the alert background
    /// - Parameter color: Some Color, if `nil` return `.black`/`.white` depends on system theme
    /// - Returns: some View
    fileprivate func textColor(_ color: Color? = nil) -> some View{
        modifier(TextForegroundModifier(color: color))
    }
}
