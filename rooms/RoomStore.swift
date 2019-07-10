//
//  RoomStore.swift
//  rooms
//
//  Created by Nikita Kazantsev on 07.07.2019.
//  Copyright © 2019 Nikita Kazantsev. All rights reserved.
//

import SwiftUI
import Combine

class RoomStore: BindableObject
{
    var rooms: [Room]
    {
        didSet{didChange.send()}
    }
    
    init(rooms: [Room] = [])
    {
        self.rooms = rooms
    }
    var didChange = PassthroughSubject<Void, Never>()
}
