//
//  ContentView.swift
//  WordScramble
//
//  Created by Tyler Sun on 1/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]() // holds words already used
    @State private var rootWord = "" // spell other words with
    @State private var newWord = "" // this will bind to a textField
    
    @State private var errotTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord).textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)// when word is added into the textfield it will call the method and add it into the list
            .onAppear(perform: startGame)
            .alert(errotTitle, isPresented: $showingError) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    // MARK: Methods
    func addNewWord() {
        // this will lowercase and trim the word checks to make sure we don't have duplocates in our array
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exits if the string is empty
        guard answer.count > 0 else { return }
         
        guard isOriginal(word: answer) else {
            wordError(title: "word already used", message: "use a different word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "word not possible", message: "can't be spelled from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else  {
            wordError(title: "\(rootWord) is not a real word", message: "Try again")
            return
        }
        
        // inserts the word at the beginning of the array
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        
        // sets new word abck to an empty string
        newWord = ""
    }
    
    func startGame() {
        // ask ios where the file is at
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            // load start.txt into a string
            if let startWords = try? String(contentsOf: startWordUrl) { // string containing all the words
                
                // this splits all the words in the file
                let allWords = startWords.components(separatedBy: "\n")
                
                // picks a random word everytime the app opens but if it does not work it will load silkworm
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // if everything works it will return
                return
            }
        }
       fatalError("could not load start.txt from bundle.")
    }
    
    
    // checks if a word has already been used yet
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // checks if a random word can be made out of the letters from another random word
    func isPossible(word: String) -> Bool {
        // create a variable of the word
        var tempWord = rootWord
        
        // loops over letters of the users input word to see if that letter exists if it does remove
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        // instance of textchecker responsible for scanning strings of misspelled words
        let checker = UITextChecker()
        // range will cover the entire legnth of the string
        let range = NSRange(location: 0, length: word.utf16.count)
            // call misspellrange so that it can look for wrong words
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    // sets the alerts to the parameters of the method
    func wordError(title: String, message: String) {
        errotTitle = title
        errorMessage = message
        showingError = true
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
