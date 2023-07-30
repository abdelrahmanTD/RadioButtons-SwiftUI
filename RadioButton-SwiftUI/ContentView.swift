//
//  ContentView.swift
//  RadioButton-SwiftUI
//
//  Created by Abdelrahman Abo Al Nasr on 29/07/2023.
//

import SwiftUI

struct ContentView: View {
    let data = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    @State private var selectedOption: String = ""

    var body: some View {
        VStack {
            Text(selectedOption)
            
            RadioButtons(options: data, selectedOption: $selectedOption)
                .optionForegroundColor(.black)
                .selectedOptionForegroundColor(.white)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
