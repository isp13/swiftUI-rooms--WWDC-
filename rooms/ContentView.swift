//
//  ContentView.swift
//  rooms
//
//  Created by Nikita Kazantsev on 07.07.2019.
//  Copyright © 2019 Nikita Kazantsev. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding var store = RoomStore()
    var body: some View {
        NavigationView{
            List{
                Section{
                    Button(action: addRoom) {
                    Text("Add Room")
                    }
                }
                
                Section{
                    ForEach(store.rooms){ room in
                RoomCell(room: room)
                        }
                        .onDelete(perform: delete)
                    }
                }
            .navigationBarTitle(Text("Rooms available"))
            .listStyle(.grouped)
    }
    }
    func addRoom(){
        store.rooms.append(Room(name: "Dungeon", capacity: 2000))
    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            store.rooms.remove(at: first)
        }
    }
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(store: RoomStore(rooms: testData))
    }
}
#endif

func resizeimage(image:UIImage,withSize:CGSize) -> UIImage {
    var actualHeight:CGFloat = image.size.height
    var actualWidth:CGFloat = image.size.width
    let maxHeight:CGFloat = withSize.height
    let maxWidth:CGFloat = withSize.width
    var imgRatio:CGFloat = actualWidth/actualHeight
    let maxRatio:CGFloat = maxWidth/maxHeight
    let compressionQuality = 0.5
    if (actualHeight>maxHeight||actualWidth>maxWidth) {
        if (imgRatio<maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight/actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }else if(imgRatio>maxRatio){
            // adjust height according to maxWidth
            imgRatio = maxWidth/actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }else{
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rec:CGRect = CGRect(x:0.0,y:0.0,width:actualWidth,height:actualHeight)
    UIGraphicsBeginImageContext(rec.size)
    image.draw(in: rec)
    let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    let imageData = image.jpegData(compressionQuality: CGFloat(compressionQuality))
    UIGraphicsEndImageContext()
    let resizedimage = UIImage(data: imageData!)
    return resizedimage!
}

struct RoomCell : View {
    let room:Room
    var body: some View {
        return NavigationButton(destination: RoomDetail(room:room))
        {
            Image(room.thumbnailName).resizable()
                .frame(width: 68.0, height: 64.0)
                .cornerRadius(6.0)
            
            
                VStack(alignment: .leading) {
                    Text(room.name)
                    Text("\(room.capacity) people") .font(.subheadline).foregroundColor(.secondary)
                    
                }
            }
        }
    }
