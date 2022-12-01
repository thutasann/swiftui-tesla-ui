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
                CustomDivider()
                CarLockButton()
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
struct CarLockButton: View{
    var body: some View{
        Button(action: {}){
            FullButton(text: "Unlock Car", icon: "lock.fill")
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


