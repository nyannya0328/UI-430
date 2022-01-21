//
//  Home.swift
//  UI-430
//
//  Created by nyannyan0328 on 2022/01/21.
//

import SwiftUI

struct Home: View {
    @State var colors : [ColorGrid] = [
    
        ColorGrid(hexValue: "#15654B", color: Color("Green")),
        ColorGrid(hexValue: "#DAA4FF", color: Color("Violet")),
        ColorGrid(hexValue: "#FFD90A", color: Color("Yellow")),
        ColorGrid(hexValue: "#FE9EC4", color: Color("Pink")),
        ColorGrid(hexValue: "#FB3272", color: Color("Orange")),
        ColorGrid(hexValue: "#4460EE", color: Color("Blue")),
    
    
    ]
    @State var animations : [Bool] = Array(repeating: false, count: 5)
    
    @State var selectedColor : Color = Color("Pink")
    
    @Namespace var animation
    
    
    @State var show : Bool = false
   
    
    var body: some View {
        VStack{
            
            
            HStack{
                
                Button {
                    
                 
                    
                } label: {
                    
                    
                    Image(systemName: "arrow.left")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                }
                .hLeading()
                
                
              
                Button {
                    
                    withAnimation{
                        
                        show.toggle()
                    }
                    
                    
                } label: {
                    
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    
                }

            
                

                
                
            }
            .overlay(Text("Credit Cart").font(.largeTitle).offset(x: -30))
            .padding([.horizontal,.top])
            .padding(.bottom,5)
            
            
            
            GeometryReader{proxy in
                
                let maxY = proxy.frame(in: .global).maxY
                
                
                CreditCardView()
                    .rotation3DEffect(.init(degrees: animations[0] ? 0 : -360), axis: (x: 1, y: 0, z: 0), anchor: .center)
                    .offset(y: animations[0] ? 0 : -maxY)
                
                
            }
            .frame(height:250)
            
            
            HStack{
                
                
                
                Text("Chose Color")
                    .hLeading()
                    .offset(x: animations[1] ? 0 : -200)
                
                
                Button {
                    
                } label: {
                    
                    Text("View All")
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.white)
                        .kerning(10)
                        .underline()
                        .offset(x: animations[1] ? 0 : 200)
                    
                }

                
                
            }
            .padding()
            
            
            GeometryReader{proxy in
                
                
                ZStack{
                    
                    Color.black.clipShape(CustomShape(corners: [.topLeft,.topRight], radius: 20))
                        .frame(height: animations[2] ? nil : 60)
                        .VBottom()
                    
                    
                    
                    ZStack{
                        
                        ForEach(colors){colorGrid in
                            
                            
                            if !colorGrid.removeFromView{
                                
                                
                                RoundedRectangle(cornerRadius: 10)
                                  .fill(colorGrid.color)
                                  .frame(width: 150, height: animations[3] ? 40 : 160)
                                  .matchedGeometryEffect(id: colorGrid.id, in: animation)
                                  .rotationEffect(.init(degrees: colorGrid.rotateCards ? 180 : 0))
                                 
                            }
                            
                        }
                    }
                    .overlay(
                    
                        RoundedRectangle(cornerRadius: 10)
                          .fill(Color("BG"))
                          .frame(width: 150, height: animations[3] ? 40 : 160)
                            .opacity(animations[3] ? 0 : 1)
                         
                    
                    
                    
                    )
                    .scaleEffect(animations[3] ? 1 : 2.2)
                    
                    
                    
                }
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 2)
                    
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        
                        ForEach(colors){colorGrid in
                            
                            
                            GirdCardView(gridCard: colorGrid)
                            
                            
                            
                        }
                        
                        
                    }
                    .padding(.top,60)
                    
                    
                }
                .cornerRadius(10)
                
                
                
              
                
                
                
                
                
            }
            .padding() 
            
            
   
            
            
            
        }
        .hCenter()
        .VTop()
        .background(Color("BG"))
        .ignoresSafeArea(.container, edges: .bottom)
        .preferredColorScheme(.dark)
        .onAppear(perform: animatedScrren)
        .popUpExtencions(horizontalPadding:50, show: $show) {
            
            
            
            List{
                
                
                ForEach(tasks){task in
                    
                    
                    
                    NavigationLink {
                        Text(task.taskDescription)
                            .navigationBarTitle("NEXT")
                    } label: {
                        
                        Text(task.taskTitle)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitle("TASK")
                        
                        
                    }

                    
                }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    
                    Button {
                        show.toggle()
                    } label: {
                        Text("Cancel")
                            .font(.footnote.weight(.semibold))
                    }

                }
                
                
                
            }
            
            
        
            
            
        }
       

    }
    
    
    @ViewBuilder
    func GirdCardView(gridCard : ColorGrid)->some View{
        
        
        
        VStack{
            
            
            if gridCard.addToGrid{
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(gridCard.color)
                    .frame(width: 150, height: 60)
                    .matchedGeometryEffect(id: gridCard.id, in: animation)
                    .onAppear {
                        
                        if let index = colors.firstIndex(where: { color in
                            
                            return gridCard.id == color.id
                        }){
                            
                            
                            withAnimation{
                                
                                
                                colors[index].showText = true
                            }
                            
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                
                                
                                
                                withAnimation{
                                    
                                    colors[index].removeFromView = true
                                }
                            }
                            
                        }
                    }
                    .onTapGesture {
                        
                        
                        selectedColor = gridCard.color
                    }
                
                
                
                
                
            }
            else{
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.clear)
                    .frame(width: 150, height: 60)
                
                
                
            }
            
            
            Text(gridCard.hexValue)
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
                .hLeading()
                .opacity(gridCard.showText ? 1 : 0)
            
        }
        
        
        
        
    }
    
    func animatedScrren(){
        
        
        withAnimation(.interactiveSpring(response: 1.5, dampingFraction: 0.7, blendDuration: 0.7).delay(0.7)){
            
            animations[0] = true
        }
        
        withAnimation(.easeInOut.delay(0.5)){
            
            animations[1] = true
        }
        
        withAnimation(.interactiveSpring(response: 1.5, dampingFraction: 1, blendDuration: 1).delay(0.3)){
            
            animations[2] = true
        }
        
        
        withAnimation(.easeInOut.delay(0.8)){
            
            animations[3] = true
        }
        
        for index in colors.indices{
            
            
            let delay : Double = (0.8 + (Double(index) * 0.1))
            
            
            let backIndex = ((colors.count - 1) - index)
            
            
            withAnimation(.easeInOut.delay(delay)){
                
                
                colors[backIndex].rotateCards = true
                
                
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                
                
                withAnimation{
                    
                    
                    colors[index].addToGrid = true
                }
                
            }
            
            
            
            
            
            
        }
        
        
     
        
        
        
        
    }
    
   
    
    @ViewBuilder
    func CreditCardView()->some View{
        
        
        ZStack{
            
            
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedColor)
            
            
            HStack(spacing:0){
                
                ForEach(1...5,id:\.self){index in
                    
                    
                  Image(systemName: "xmark")
                        .font(.callout)
                    
                }
                
              Text("9999")
                    .font(.callout)
                    .foregroundColor(.black)
                
            }
            .padding()
            .hLeading()
            .VTop()
            
            
            
            
            HStack(spacing:-8){
                
                
                Text("Manami")
                    .font(.title.weight(.semibold))
                    .hLeading()
                
              
                
                Circle()
                    .stroke(.red,lineWidth: 1)
                    .frame(width: 30, height: 30)
                
                Circle()
                    .stroke(.blue,lineWidth: 1)
                    .frame(width: 30, height: 30)
                
                Circle()
                    .stroke(.green,lineWidth: 1)
                    .frame(width: 30, height: 30)
                
              
                
                
                
               
                
                
            }
            .padding()
            .VBottom()
            
            
            
            Circle()
                .stroke(Color.white,lineWidth: 30)
                .offset(x: 120, y: -90)
            
            
        }
        .clipped()
        .padding()
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
