//
//  Library.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 09.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry  in
                    HStack (spacing: 20){
                        Button(action: {
                            print("1")
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width/2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.8970172339, green: 0.8970172339, blue: 0.8970172339, alpha: 1)))
                                .cornerRadius(10) }
                        )
                        Button(action: {
                            print("2")
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width/2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.8970172339, green: 0.8970172339, blue: 0.8970172339, alpha: 1)))
                                .cornerRadius(10) }
                        )
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                List {
                    LibraryCell()
                }
            }
            .navigationBarTitle("Library", displayMode: .large)
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image.init(uiImage: #imageLiteral(resourceName: "Image"))
                .frame(width: 60, height: 60)
            VStack{
                Text("halo")
                Text("halo").foregroundColor(Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
