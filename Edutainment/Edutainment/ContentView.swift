//
//  ContentView.swift
//  Edutainment
//
//  Created by Tyler Sun on 1/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var num1 = Int()
    @State private var num2 = Int()
    @State private var difficulty = 2 // binds with stepper
    @State private var amountOfQuestions = 5 // binds with picker
    let questionOptions = [5, 10, 20]
    
    @State private var questionCount = 0
    @State private var choices = [Int]()
    @State private var correctAnswer = Int()
    @State private var points = 0
    @State private var gameLimit = false
    @State private var isVisble = false

    var body: some View {
        VStack {
                HStack {
                    Stepper("Choose difficulty", value: $difficulty, in: 2...12)
                    Text("\(difficulty)")
                }
                .padding()
                
                VStack {
                    Text("Choose amount of Questions")
                    Picker("Amount of Questions", selection: $amountOfQuestions) {
                        ForEach(questionOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)

                    VStack(spacing: 200) {
                        Text("What is \(num1) * \(num2)")
                        
                        HStack(spacing: 50) {
                            ForEach(choices, id: \.self) { num in
                                Button {
                                    withAnimation {
                                        numberTapped(num)
                                        questionCount += 1
                                        print(questionCount)
                                    }
                                } label: {
                                    Text("\(num)")
                                        .font(.largeTitle)
                                        .foregroundColor(.cyan)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    if !isVisble {
                        Button {
                            options()
                            isVisble.toggle()
                        } label: {
                            Text("Lets Go!")
                                .foregroundColor(.indigo)
                        }
                    }
                    Text("\(points) points")
                }
                .padding()
                .navigationTitle("Multiplication")
                .alert("Question lImit hit", isPresented: $gameLimit) {
                    Button("ok") {
                        resetGame()
                    }
                } message: {
                    Text("you score was \(points)")
                }
        }
    }
    
    // MARK: methods
    
    func optionsGenerator() {
        choices.shuffle()
    }
    
    func options() {
        for _ in 1...2 {
            num1 = Int.random(in: 1...difficulty)
            num2 = Int.random(in: 1...difficulty)
            
            correctAnswer = num1 * num2
            choices.append(correctAnswer)
        }
            optionsGenerator()
    }
    
    func numberTapped(_ num: Int) {
        
        if num == correctAnswer {
            choices.removeAll()
            points += 1
            print("correct")
            options()
        } else if num != correctAnswer {
            choices.removeAll()
            print("wrong")
            options()

        }
        if amountOfQuestions == questionCount {
            gameLimit = true
        }
    }
    
    func resetGame() {
        points = 0
        questionCount = 0
        choices.removeAll()
        isVisble.toggle()
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
