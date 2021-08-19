//
//  MediumPlaceholder.swift
//  MainWidgetExtension
//
//  Created by 朵朵 on 2021/8/6.
//

import SwiftUI

struct MediumPlaceholder: View {
    
    private var scare : CGFloat = (UIScreen.main.bounds.size.width / 375);

    
    var body: some View {
        
        GeometryReader{proxy in
            
            
            ZStack{
                
                Image("bg_orange")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                VStack{
                    Spacer().frame(height:0)
                    ZStack{
                        Rectangle().frame(height:44,alignment: .leading).foregroundColor(.clear)
                        HStack{
                            Spacer().frame(width:15)
                            Image("icon_heshenghuologo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 24, alignment: .leading)
                            Spacer()
                        }
                    }
                    Spacer().frame(height:0)
                    ZStack{
                        RoundedCorner(radius: 20, corners:[.topLeft ,.topRight]).foregroundColor(.white)
                        HStack(spacing: 10.0*scare) {
                            placeIcon()
                            placeIcon()
                            placeIcon()
                            teamIcon(icon: "")
                        }
                        
                    }
                    Spacer().frame(height:0)
                }
            }
        }
    }
}

struct placeIcon: View {
    private var scare : CGFloat = (UIScreen.main.bounds.size.width / 375);
    
    //把网络请求的数据带过来 占位图不用带
    //var entry : MediumProvider.Entry? = nil
    
    var body: some View {
        
        ZStack {
            VStack{
                Spacer().frame(height:8)
                RoundedCorner(radius: 8, corners: .allCorners)
                    .foregroundColor(Color.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0))
                    .frame(width: 72*scare, height: 72*scare, alignment: .center)
                    //.blur(radius: 5)
                Spacer().frame(height:5)
                Text("¥--")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                Spacer()
            }.frame(width: 72*scare, height: 88*scare, alignment: .center)
            
        }
    }

}
struct teamIcon: View {
    
    var icon:String = ""
    init(icon: String) {
        self.icon = icon
    }
    private var scare : CGFloat = (UIScreen.main.bounds.size.width / 375);
    var body: some View {
        ZStack {
            if (self.icon.count > 0){
                Image(self.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.red)
                    .frame(width: 40*scare, height: 88*scare, alignment: .center)
            }else{
                RoundedCorner(radius: 5, corners: .allCorners)
                    .foregroundColor(Color.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0))
                    .frame(width: 40*scare, height: 88*scare, alignment: .center)
            }
            
            
        }
    }

}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct MediumPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        MediumPlaceholder()
    }
}
