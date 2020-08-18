//
//  MenuList.swift
//  iDine
//
//  Created by Aldana Al-Rashidi on 8/5/20.
//  Copyright © 2020 Aldana Al-Rashidi. All rights reserved.
//

import SwiftUI

struct MenuList: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView{
            // for each section in my menu "menu.json".
            List{
                // The name of our section
                ForEach(menu){ section in
                    Section(header: Text(section.name)){
                        
                        // The items inside each section & their descriptions
                        ForEach(section.items){ item in
                           ItemRow(item: item)
                        }
                    }
                }
            }.navigationBarTitle("Menu")
            .listStyle(GroupedListStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MenuList()
    }
}
