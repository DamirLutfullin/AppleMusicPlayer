//
//  Library.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 09.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = TraksStore.tracksForList
    @State private var showingAlert = false
    @State private var cell: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate!
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry  in
                    HStack (spacing: 20){
                        Button(action: {
                            self.cell = self.tracks.first
                            self.tabBarDelegate.maximaizeTrackDetailController(viewModel: self.cell)
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width/2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.8970172339, green: 0.8970172339, blue: 0.8970172339, alpha: 1)))
                                .cornerRadius(10) }
                        )
                        Button(action: {
                            self.tracks = TraksStore.tracksForList
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
                    ForEach(tracks, id: \.self) { track in
                        LibraryCell(cell: track)
                            .gesture(LongPressGesture()
                                .onEnded { _ in
                                    self.cell = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                    .onEnded { _ in
                                       let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.rootViewController as? MainTabBarController
                                        keyWindow?.trackDetailView.delegateForTrackMoving = self
                                        
                                        self.cell = track
                                        self.tabBarDelegate.maximaizeTrackDetailController(viewModel: track)
                                    }))
                    }.onDelete(perform: delete(offSet:))
                }
                
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(
                    title: Text("are you should u want to delete whis track"),
                    buttons: [
                        .cancel(),
                        .destructive(Text("Delete"), action: { self.delete(track: self.cell)})
                    ]
                )
            })
                .navigationBarTitle("Library", displayMode: .large)
        }
    }
    
    func delete(offSet: IndexSet) {
        tracks.remove(atOffsets: offSet)
        TraksStore.tracksForList.remove(atOffsets: offSet)
    }
    
    func delete(track: SearchViewModel.Cell) {
        guard let index = tracks.firstIndex(of: track) else { return }
        tracks.remove(at: index)
        TraksStore.tracksForList.remove(at: index)
    }
}

struct LibraryCell: View {
    var cell: SearchViewModel.Cell
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!)
                .frame(width: 60, height: 60)
                .cornerRadius(2)
            VStack(alignment: .leading) {
                Text(cell.trackName)
                Text(cell.artistName).foregroundColor(Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library:  TrackMovingDelegate {
    
    func moveToPreviosTrack() -> SearchViewModel.Cell? {
        guard let index = tracks.firstIndex(of: cell) else { return nil }
        let nextTrack: SearchViewModel.Cell
        if index - 1 == 0 {
            nextTrack = tracks.last!
        } else {
            nextTrack = tracks[index-1]
        }
        self.cell = nextTrack
        return cell
    }
    
    func moveToNextTrack() -> SearchViewModel.Cell? {
        guard let index = tracks.firstIndex(of: cell) else { return nil }
        let nextTrack: SearchViewModel.Cell
        if index + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[index+1]
        }
        self.cell = nextTrack
        return cell
    }
}
