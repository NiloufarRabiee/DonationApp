//
//  WelcomePage.swift
//  demooqrcodee
//
//  Created by Niloufar Rabiee on 18/12/24.
//

import SwiftUI

struct WelcomePage: View {
    @State private var mealCount: Int = 5
    let mealPrice = 2.0 // Price per meal in AUD
    
    var totalAmount: Double {
        return Double(mealCount) * mealPrice
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.8)]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Header Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome,")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("2,024,259")
                                    .font(.title2)
                                    .foregroundColor(Color.yellow)
                                    .bold()
                                Text("meals donated")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                print("View Impact tapped")
                            }) {
                                Text("View Impact")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Donation Section
                    VStack {
                        Image("meal_placeholder") // Replace with an image asset
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .padding(.bottom, 10)
                        
                        Text("\(mealCount)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.yellow)
                        
                        Text("meal(s)")
                            .foregroundColor(.white)
                        
                        // Slider
                        HStack {
                            Button(action: {
                                if mealCount > 1 { mealCount -= 1 }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                            }
                            
                            Slider(value: Binding(
                                get: { Double(mealCount) },
                                set: { mealCount = Int($0) }),
                                   in: 1...20,
                                   step: 1
                            )
                            .accentColor(.yellow)
                            
                            Button(action: {
                                if mealCount < 20 { mealCount += 1 }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                            }
                        }
                        
                        Text(String(format: "$%.2f AUD", totalAmount))
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 5)
                        
                        Button(action: {
                            print("Donate tapped")
                        }) {
                            Text("Donate")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.yellow)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.vertical, 16)
                    
                    
                    // Informational Section
                    VStack(alignment: .center, spacing: 10) {
                        Text("More Features")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(4)
                            .bold()
                        Text("Search For More Donations")
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.bottom, 10)
                            .font(.subheadline)
                        
                        // Centered Start Button
                        NavigationLink(destination: MoreFeatures().navigationBarBackButtonHidden(true)) {
                            
                                Text("Start")
                                    .frame(width: 80, height: 35)
                                    .foregroundColor(.black)
                                    .background(Color.yellow)
                                    .cornerRadius(8)
                           
                        }
                        // Ensures horizontal centering
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Bottom Navigation Text Only
                    Text("Powered by Your Support")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .padding(.bottom, 10)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
            .preferredColorScheme(.dark)
    }
}

