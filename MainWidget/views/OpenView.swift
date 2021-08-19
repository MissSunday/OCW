//
//  OpenView.swift
//  MainWidgetExtension
//
//  Created by 朵朵 on 2021/8/4.
//

import SwiftUI

struct OpenView: View {
    
    var body: some View {
        
        GeometryReader{proxy in
            ZStack{
                Image("bg_hexiaoxiong")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                
                VStack(){
                    Spacer().frame(height: 12)
                    HStack{
                        Spacer().frame(width: 10)
                        Image("icon_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20, alignment: .leading)
                        Spacer().frame(width: 2)
                        Text("欢迎回家")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        Spacer()
                    }.frame(width: proxy.size.width,height: 20 ,alignment: .topLeading)
                    Spacer().frame(height:proxy.size.height-42,alignment: .topLeading)
                }
                VStack(){
                    Spacer().frame(height:proxy.size.height - 47)
                    HStack(){
                        Spacer().frame(width:10)
                        Button(action: {
                            
                        }, label: {
                            Text("开门")
                                .foregroundColor(Color.init(red: 255/255.0, green: 156/255.0, blue: 26/255.0))
                                .font(.system(size: 14))
                        })
                        .frame(width: 64, height: 32,alignment: .center)
                        .background(Color.white)
                        .clipped()
                        .cornerRadius(16)
                    }
                    Spacer().frame(height:15)
                }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .leading)
            }
        }
    }
}
struct OpenView_Previews: PreviewProvider {
    static var previews: some View {
        OpenView()
    }
}
