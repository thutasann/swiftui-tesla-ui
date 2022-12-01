//
//  CommonComponent.swift
//  TeslaUI
//
//  Created by Thuta sann on 11/30/22.

import Foundation
import SwiftUI


// MARK: - General Buttons (For General)
struct HeaderButton: View{
    
    var icon: String
    
    var body: some View{
        Image(systemName: icon)
            .imageScale(.large)
            .frame(width: 44, height: 44)
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}


// MARK: - Custom Divider
struct CustomDivider: View{
    var body: some View{
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 0.5)
            .background(Color.white)
            .opacity(0.1)
    }
}


// MARK: - Action buttons
struct  ActionButton: View{
    
    var item: ActionItem
    
    var body: some View{
        VStack(alignment: .center){
            HeaderButton(icon: item.icon)
            Text(item.text)
                .frame(width: 72)
                .font(.system(size: 12, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
        }
    }
}

struct ActionItem: Hashable{
    var icon: String
    var text: String
}


// MARK: - Car Lock Button
struct FullButton: View {
    
    var text: String
    var icon: String = ""
    
    var body: some View{
        if icon.isEmpty{
            textButton
        }else{
            iconButton
        }
    }
    
    var iconButton: some View {
        Label(text, systemImage: icon)
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
    
    
    var textButton: some View{
        Text(text)
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

