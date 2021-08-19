//
//  MediumView.swift
//  MainWidgetExtension
//
//  Created by 朵朵 on 2021/8/6.
//

import SwiftUI

struct MediumView: View {
    private var scare : CGFloat = (UIScreen.main.bounds.size.width / 375);
    var entry: MediumEntry? = nil

    init(entry: MediumEntry) {
        self.entry = entry
    }
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
                            Link(destination: URL(string: "http://baidu.com")!){
                                placeIcon()
                            }
                            Link(destination: URL(string: "http://yyy.com")!){
                                placeIcon()
                            }
                            Link(destination: URL(string: "http://ddd.com")!){
                                placeIcon()
                            }
                            Link(destination: URL(string: "http://ccc.com")!){
                                teamIcon(icon: "pic_hezuopingtai")
                            }
                        }
                        
                    }
                    Spacer().frame(height:0)
                }
            }
        }
    }
}

//struct MediumView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediumView()
//    }
//}
