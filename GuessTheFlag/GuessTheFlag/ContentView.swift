//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tyler Sun on 1/10/23.
//

import SwiftUI

struct ContentView: View {
// this will track if the alert is showing or not right now it is not
    // MARK: Step one of alert controller is to create a state that tracks if the aler is showing
@State private var showingScore = false
// stores title of players score inside of the alert
@State private var scoreTitle = ""
@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
@State private var correctAnswer = Int.random(in: 0...2)
@State private var score = 0
@State private var limit = false
@State private var turns = 0

    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                            reset()
                        } label: {
                            Image(countries[number]).renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .padding()
            }
        }
        // the alert will show scoring title and us the askQuestion method
        // set showing score to true
        // MARK: Step two is we attach the alert to the interface
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Turn limit reached 8", isPresented: $limit) {
            Button("Reset", action: reset)
        } message: {
            Text("")
        }
    }
    // this will accept the number of the button tapped and compare it to the correct answer
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            turns += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
            turns += 1
        }
           showingScore = true
    }
    // this func should reset the game reshuffle the countries and picking a new correct answer
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
 // this will reset the score board
    func reset() {
        if turns == 8 {
           score = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
