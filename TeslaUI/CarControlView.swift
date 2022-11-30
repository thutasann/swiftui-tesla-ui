//
//  CardContentView.swift
//  TeslaUI
//
//  Created by Thuta sann on 11/30/22.
//

import SwiftUI

let carControls: [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Flash"),
    ActionItem(icon: "speaker.wave.3.fill", text: "Honk"),
    ActionItem(icon: "key.fill", text: "Start"),
    ActionItem(icon: "arrow.up.bin", text: "FrontTrunk"),
    ActionItem(icon: "arrow.up.square", text: "Trunk"),
]

struct CarControlView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var toggleValet: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                VStack (alignment: .leading, spacing: 10 ) {
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            HeaderButton(icon: "chevron.left")
                        }
                        Spacer()
                    }
                    Text("Car Control")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                CustomDivider()
                CarLockButton()
                CustomDivider()
                ActionButtons()
                CustomDivider()
                HStack{
                    Text("Valet Mode")
                        .fontWeight(.semibold)
                    Spacer()
                    Toggle("", isOn: $toggleValet)
                }
                if toggleValet{
                    Text("Valet Mode is On!")
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DrakGray"))
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
}




// MARK: - Car Lock Button
struct CarLockButton: View {
    var body: some View {
        Button(action: {}){
            Label("Unlock car", systemImage: "lock.fill")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                )
        }
    }
}

// MARK: - Aciton Buttons
struct ActionButtons: View {
    var body: some View {
        VStack (spacing: 20){
            HStack{
                Spacer()
                ActionButton(item: carControls[0])
                Spacer()
                ActionButton(item: carControls[1])
                Spacer()
                ActionButton(item: carControls[2])
                Spacer()
            }
            HStack{
                Spacer()
                ActionButton(item: carControls[3])
                Spacer()
                ActionButton(item: carControls[4])
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}


// MARK: - Preview
struct CarControlView_Previews: PreviewProvider {
    static var previews: some View {
        CarControlView()
    }
}


