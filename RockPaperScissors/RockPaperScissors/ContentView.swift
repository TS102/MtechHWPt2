//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tyler Sun on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var playerWon = false
    @State private var needToWin = Bool.random()
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var score = 0
    @State private var movesArray = ["rock", "paper", "scissors"]
    @State private var winningArray = ["paper", "scissors", "rock"]
    
    
    @State private var alertIsShown = false
    @State private  var rounds = 0
    
    var game: String {
        if movesArray[computerChoice] == "Rock" {
            return "Paper"
        } else if movesArray[computerChoice] == "Paper" {
            return "Scissors"
        } else {
            return "Rock"
        }
        // this will return a winning answer
    }
    
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors")
                .font(.largeTitle)
            VStack {
                Text("Computer Chose \(movesArray[computerChoice])")
                    .font(.title3)
                    .padding()
                Text(needToWin ? "You Need To Win" : "You Need to lose")
                    .font(.title2)
                VStack(spacing: 20) {
                    ForEach(0...2, id: \.self) { number in
                        Button {
                            buttonTapped(number)
                            computerChoosesAgain()
                        } label: {
                            Text(movesArray[number])
                        }
                    
                    }
                    Section {
                        Text("Score: \(score)")
                    }
                }
            }
        }
        .alert("Good Job Your score was \(score) after 10 rounds", isPresented: $alertIsShown) {
            Button("Ok") {
                reset()
            }
        }
        
    }
    
    // MARK: Methods
    
    func buttonTapped(_ number: Int) {
        rounds += 1
        var isCorrect: Bool
    
        switch (computerChoice, number, needToWin) {
        case (0, 1, true) : isCorrect = true
        case (1, 2, true) : isCorrect = true
        case(2, 0, true) : isCorrect = true
        case(0, 2, false) : isCorrect = true
        case(1, 0, false) : isCorrect = true
        case(2, 1, false) : isCorrect = true
        default: isCorrect = false
        }
        if isCorrect {
            score += 1
        } else {
            score -= 1
        }
        if rounds == 10 {
            alertIsShown = true
        }
    }
    
    func reset() {
        
    }
    func computerChoosesAgain() {
        computerChoice = Int.random(in: 0...2)
        needToWin.toggle()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
