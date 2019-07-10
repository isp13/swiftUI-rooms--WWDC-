//
//  RoomDetail.swift
//  rooms
//
//  Created by Nikita Kazantsev on 07.07.2019.
//  Copyright © 2019 Nikita Kazantsev. All rights reserved.
//

import SwiftUI

struct RoomDetail : View {
    let room: Room
    @State private var zoomed = false
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
        Image(room.thumbnailName)
            .resizable()
            .aspectRatio(contentMode: zoomed ? .fill : .fit)
            .blur(radius: 0.0)
            .navigationBarTitle(Text(room.name), displayMode: .inline)
            .tapAction {
                withAnimation{self.zoomed.toggle()}
            }
            .frame(minWidth:0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity)
            
            if room.hasVideo && !zoomed {
            Image(systemName: "video.fill").font(.title).padding(.all)
                .transition(.move(edge: .leading))
            }
        }
        
    }
}

#if DEBUG
struct RoomDetail_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView{ RoomDetail(room: testData[0])}
    }
}
#endif
