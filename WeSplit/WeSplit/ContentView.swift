//
//  ContentView.swift
//  WeSplit
//
//  Created by Tyler Sun on 1/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0 // State allows you to worki around the limitations of a struct
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 + tipSelection
        let totalAmoount = checkAmount + tipValue
        let amoutPerPerson = totalAmoount / peopleCount

        return amoutPerPerson
    }
    
    var totalBeforSplit: Double {
        let tip = Double(tipPercentage)
        let totalAmount = checkAmount + tip
        return totalAmount
        
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection:  $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalBeforSplit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
               ToolbarItemGroup(placement: .keyboard) {
                   Spacer()
                   
                   Button("Done") {
                       amountIsFocused = false
                   }
               }
           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
