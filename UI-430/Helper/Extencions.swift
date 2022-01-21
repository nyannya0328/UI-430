//
//  Extencions.swift
//  UI-430
//
//  Created by nyannyan0328 on 2022/01/21.
//

import SwiftUI

extension View{
    
    
    func popUpExtencions<Content : View>(horizontalPadding : CGFloat = 40,show : Binding<Bool>,@ViewBuilder content : @escaping()->Content)->some View{
        
        return self
        
            .overlay{
                
                if show.wrappedValue{
                    
                    Color.black.opacity(0.2)
                        .frame(maxWidth:.infinity,maxHeight: .infinity)
                        .ignoresSafeArea()
                    
                    GeometryReader{proxy in
                        
                        
                        let size = proxy.size
                        
                        
                        NavigationView{
                            
                            
                            content()
                                
                        }
                        .padding()
                        .frame(width: size.width - horizontalPadding, height: size.height / 1.3)
                        .frame(maxWidth:.infinity,maxHeight: .infinity)
                        .cornerRadius(20)
                        
                        
                        
                        
                    }
                }
                
                
                
            }
        
        
        
        
        
    }
    
    
    func hLeading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    func hTrailing()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    func hCenter()->some View{
        
        self
            .frame(maxWidth:.infinity)
    }
    
    
    func VTop()->some View{
        
        self
            .frame(maxHeight:.infinity,alignment: .top)
    }
    
    func VBottom()->some View{
        
        self
            .frame(maxHeight:.infinity,alignment: .bottom)
    }

}


struct CustomShape : Shape{
    
    let corners : UIRectCorner
    let radius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
