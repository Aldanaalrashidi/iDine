//
//  ItemRow.swift
//  iDine
//
//  Created by Aldana Al-Rashidi on 8/5/20.
//  Copyright © 2020 Aldana Al-Rashidi. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
    static let colors: [String: Color] = ["D": Color.purple,
                                          "G": Color.black,
                                          "N": Color.red,
                                          "S": Color.blue,
                                          "V": Color.green
                                          ]
    var item: MenuItem
    var body: some View {
        NavigationLink(destination: ItemDetail(item: item)){
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 0.7))
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("\(item.price) KD")
                }.layoutPriority(1)
                // the lay out priority makes our name or text fill without showing alda... (the dots)
                
                Spacer()
                
                ForEach(item.restrictions, id: \.self) { restriction in
                    Text(restriction)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(5)
                        .background(Self.colors[restriction])
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
