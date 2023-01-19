//
//  ContentView.swift
//  BetterRest
//
//  Created by Tyler Sun on 1/15/23.
//

import CoreML // what you need to use the ML file made
import SwiftUI

struct ContentView: View {
   static  var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    } // default wake up time of 7am of the current date
    
    @State private var sleepAmoont = 8.0 // used to bind to the stepper
    @State private var wakeUp = defaultWakeTime // used to bind with the datepicker
    @State private var coffeeAmount = 1 // used to bind to a different stepper
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
 
    var body: some View {
        NavigationStack {
            Form {
                
                Section() {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("please enter time", selection: $wakeUp, displayedComponents: .hourAndMinute) // choose hour & min because we want the time not the day
                        .labelsHidden() // hides the label
                }
                // sleep stepper
                Section() {
                    Text("Choose the amount of sleep you want.")
                        .font(.headline)
                    
                    Stepper("\(sleepAmoont.formatted()) hours", value: $sleepAmoont, in: 4...12, step: 0.25)
                }
                Section() {
                    // coffee stepper
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(0 ..< 20) { cups in
                            Text(cups == 1 ? "1 cup" : "\(cups) cups")
                            
                        }
                    }
                }
            } .navigationTitle("Better Rest")
                .toolbar {
                Button("Calculate", action: calculateBedTime)
                }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("ok") {}
                } message: {
                    Text(alertMessage)
                }
        }
    }
    
    // MARK: methods
    func calculateBedTime() {
        // we need to convert date into double
        do {
            let config = MLModelConfiguration() // instance of ML model
            let model = try SleepCalculator(configuration: config) // reads all the data we want
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp) // grabs the hour and min of wakeup
            
            let hour = (components.hour ?? 0) * 60 * 60 // min and hour are optional so we have to unwrap if it fails it will set an hour
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmoont, coffee: Double(coffeeAmount)) // this converts out date into a double but it will show the time in seconds which we don't want
            
            let sleepTime = wakeUp - prediction.actualSleep // this gives back an actual time
            alertTitle = "your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            // if it fails
            alertTitle = "error"
            alertMessage = "There was a problem calculating your betime."
        }
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
