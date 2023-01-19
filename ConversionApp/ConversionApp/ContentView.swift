//
//  ContentView.swift
//  ConversionApp
//
//  Created by Tyler Sun on 1/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var CurrentTemp = 0
    @State private var selectedTemp = "Celsius"
    @State private var newTemp = "Fahrenheit"
    
    
    
    let temps = ["Celsius", "Fahrenheit", "Kelvin"]
    let tempatures = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var celsius: Double {
      let celsius = Double(CurrentTemp)
        
        return celsius * 0.56 - 32
    }
    
    var fahrenheit: Double {
        let currentTemp = Double(CurrentTemp)
        return currentTemp * 1.8 + 32
    }
    
    var kelvin: Double {
        let currentTemp = Double(CurrentTemp)
        return currentTemp + 273.15
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("select Temp", selection: $selectedTemp) {
                        ForEach(temps, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Current Tempature", value: $CurrentTemp, format: .number)
                } header: {
                    Text("What is the Tempature?")
                }
                
                Section {
                    switch selectedTemp {
                    case "Celsius":
                        Text("\(celsius, format: .number) Degrees Celsius")
                    case "Fahrenheit":
                        Text("\(fahrenheit, format: .number) Degrees Fahrenheit")
                    case "Kelvin":
                        Text("\(kelvin, format: .number) Degrees Kelvin")
                    default:
                        Text("I guess tempature has not been invented")
                    }
                }
        
                Section {
                    Picker("Select a Temp", selection:  $newTemp) {
                        ForEach(tempatures, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select a Tempature")
                }
                .pickerStyle(.segmented)
                
                Section {
                    switch newTemp {
                    case "Celsius":
                        Text("The current Tempature is \(celsius, format: .number) degrees Celsius")
                    case "Fahrenheit":
                        Text("The current Tempature is \(fahrenheit, format: .number) degrees Fahrenheit")
                    case "Kelvin":
                        Text("The current Tempature is \(kelvin, format: .number) degrees Kelvin")
                    default:
                        Text("I guess the world is ending")
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

