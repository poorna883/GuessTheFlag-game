//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Poorna Chandra Vemula on 14/01/20.
//  Copyright © 2020 Poorna Chandra Vemula. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State var correctAnswer = Int.random(in: 0 ... 2)
    
    @State private var ShowingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var alertMessage = ""
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3){ number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                        
                    }
                }
                Text("your current score is \(userScore)")
                    .foregroundColor(.white)
                Spacer()
            }
            .alert(isPresented: $ShowingScore) {
                Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
            }
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle="Correct"
            userScore+=1
            alertMessage = "your score is \(userScore)"
        }else{
            scoreTitle="Wrong"
            alertMessage = "Wrong! That's the flag of \(countries[number])"
        }
        ShowingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

