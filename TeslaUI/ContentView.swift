//
//  ContentView.swift
//  TeslaUI
//
//  Created by Thuta sann on 11/30/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
                
            ScrollView{
                HomeHeader()
                    .padding()
            }
            
            // Voice Command Button
            VoiceCommandButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DrakGray"))
        .foregroundColor(Color.white)
    }
}


// MARK: - ContentPreviews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: - Voice Command Button
struct VoiceCommandButton: View{
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                
                // Mic Icon
                Image(systemName: "mic.fill")
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .frame(width: 64, height: 64)
                    .background(Color("Green"))
                    .foregroundColor(Color("DrakGray"))
                    .clipShape(Circle())
                    .padding()
                    .shadow(radius: 10)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - Home Header
struct HomeHeader: View{
    var body: some View{
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color("Red"))
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            HStack{
                
            }
        }
    }
}
