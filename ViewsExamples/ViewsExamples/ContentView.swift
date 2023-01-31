//
//  ContentView.swift
//  ViewsExamples
//
//  Created by Tyler Sun on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            Text("hello world")
        // MARK: using maxwidth and maxheight to make the background red
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(.red)
        //MARK: example of knowing where to put modifiers
        Button("hello") {
            print(type(of: self.body))
        }
            .frame(width: 200, height: 200) // if this is flipped with the background you would get a red sqaure around the butto thats not the length of the frame
            .background(.red)
        
        
        //MARK: use of padding example
//        Text("Hello, world!")
//            .padding()
//            .background(.red)
//            .padding()
//            .background(.blue)
//            .padding()
//            .background(.green)
//            .padding()
//            .background(.yellow)
//
    }

}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
