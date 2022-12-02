//
//  ContentView.swift
//  TeslaUI
//
//  Created by Thuta sann on 11/30/22.
//

import SwiftUI


// MARK: - MAIN CONTENT VIEW FOR HOME SCREEN
struct ContentView: View {
    
    @State private var openVoiceCommand: Bool = false
    @State private var openMediaControls: Bool = false
    @State private var openCharging: Bool = false
    
    @State private var actionText : String = ""
    @State private var actionIcon : String = ""
    @State private var openAction : Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView{
                    VStack(spacing: 20){
                        HomeHeader()
                        CustomDivider()
                        CarSection(openCharging: $openCharging)
                        CustomDivider()
                        CategoryView(
                                openAction: $openAction,
                                actionText: $actionText,
                                actionIcon: $actionIcon,
                                openCharging: $openCharging,
                                openMedia: $openMediaControls,
                                title: "Quick Shortcuts",
                                showEdit: true,
                                actionItems: quickShortcuts
                        )
                        CustomDivider()
                        CategoryView(
                            openAction: $openAction,
                            actionText: $actionText,
                            actionIcon: $actionIcon,
                            openCharging: $openCharging,
                            openMedia: $openMediaControls,
                            title: "Recent Actions",
                            showEdit: true,
                            actionItems: quickShortcuts
                        )
                        CustomDivider()
                        AllSettings()
                        RecorderButton()
                    }
                    .padding()
                }
                
                VoiceCommandButton(open: $openVoiceCommand)
                
                // Action Buttons Background Images Fade
                if (openVoiceCommand || openCharging || openMediaControls || openAction){
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture{
                            withAnimation {
                                openVoiceCommand = false
                                openCharging = false
                                openMediaControls = false
                                openAction = false
                            }
                        }
                }
                
                // Voice Command View
                if openVoiceCommand{
                    VoiceCommandView(open: $openVoiceCommand, text: "Take me to Olive Garden")
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                
                // Open Charging View
                if openCharging{
                    ChargingView()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                
                // Open Media Controls
                if openMediaControls{
                    MediaPlayer()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                // Action Notificatin
                if openAction && !actionText.isEmpty{
                    ActionNotification(open: $openAction, icon: actionIcon, text: actionText)
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DrakGray"))
            .foregroundColor(Color.white)
            .navigationBarHidden(true)
        }
    }
}


// MARK: - Voice Command Button
struct VoiceCommandButton: View{
    
    
    @Binding var open : Bool
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                
                Button(action:{
                    withAnimation{
                        open = true
                    }
                }){
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
                Button(action: {}){
                    HeaderButton(icon: "lock.fill")
                }
                Button(action: {}){
                    HeaderButton(icon: "gear")
                }
            }
        }
        .padding(.top)
    }
}


// MARK: - Car Section
struct CarSection: View{
        
    @Binding var openCharging : Bool
    
    var body: some View{
        VStack (spacing:10){
            HStack(alignment: .center){
                
                Button(action : {
                    withAnimation {
                        openCharging = true
                    }
                }){
                    Label("237 miles".uppercased(), systemImage: "battery.75")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Green"))
                }
                
                Spacer()
                VStack(alignment: .trailing){
                    Text("Parked")
                        .fontWeight(.medium)
                    Text("Last updated: 5min go")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            Image("car")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

// MARK: - Category Header
struct CategoryHeader: View{
    
    var title: String
    var showEdit: Bool = false
    
    var body: some View{
        HStack(alignment: .center){
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            if showEdit{
                Button(action: {}){
                    Text("Edit")
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                }
            }
        }
    }
}

// MARK: - Category View
struct CategoryView: View{
    
    @Binding var openAction: Bool
    @Binding var actionText: String
    @Binding var actionIcon: String
    
    @Binding var openCharging: Bool
    @Binding var openMedia: Bool
    
    var title: String
    var showEdit: Bool = false
    
    var actionItems: [ActionItem]
    
    var body: some View{
        VStack{
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false){
                                
                HStack (alignment: .top){
                    if title == "Quick Shortcuts"{
                        
                        Button(action: {
                            withAnimation {
                                openCharging = true
                            }
                        }){
                            ActionButton(item: chargingShortcut)
                        }
                        
                        Button(action: {
                            withAnimation {
                                openMedia = true
                            }
                        }){
                            ActionButton(item: mediaShortcut)
                        }
                        
                    }
                    ForEach(actionItems, id:\.self){ item in
                        Button(action : {
                            withAnimation {
                                openAction = true
                                actionText = item.text
                                actionIcon = item.icon
                            }
                        }){
                            ActionButton(item: item)
                        }
                    }
                }
            }
        }
    }
}


let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "fanblades.fill", text: "Fan on"),
    ActionItem(icon: "bolt.car", text: "Charge Port")
]

// For onTap Action
let chargingShortcut = ActionItem(icon: "bolt.fill", text: "Charging")
let mediaShortcut =  ActionItem(icon: "play.fill", text: "Media")


let recentShortcuts: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Open Trunk"),
    ActionItem(icon: "fanblades", text: "Fan Off"),
];

// MARK: - All Settings
struct AllSettings: View{
    var body: some View{
        VStack{
            CategoryHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(.fixed(190)), GridItem(.fixed(190))]){
                
                NavigationLink(destination: CarControlView()){
                SettingBlock(icon: "car.fill", title: "Controls", subtitle: "CAR CONTROL", hasSubtitle: true)
                }
                
                SettingBlock(icon: "fanblades.fill", title: "Climate", subtitle: "Interior 68° F", hasSubtitle: true, backgroundColor: Color.blue)
                
                NavigationLink(destination: LocationView()){
                    SettingBlock(icon: "location.fill",  title: "Location", subtitle: "EMPIRE STATE BUILDING", hasSubtitle: true)
                }
               
                SettingBlock(icon: "sparkles", title: "Upgrades", subtitle: "3 upgrades available", hasSubtitle: true)
                SettingBlock(icon: "checkerboard.shield", title: "Security", subtitle: "0 EVENTS DETECTED", hasSubtitle: true)
            }
        }
    }
}

struct SettingBlock: View{
        
    var icon: String
    var title: String
    var subtitle: String = ""
    var hasSubtitle: Bool = false
    
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    var body: some View{
        HStack(alignment: .center, spacing: 5){
            Image(systemName: icon)
            VStack(alignment: .leading){
                Text(title)
                    .fontWeight(.semibold)
                if(hasSubtitle){
                    Text(subtitle.uppercased())
                        .font(.system(size: 10, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.leading, 5)
            Spacer()
            Image(systemName: "chevron.right")
            
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.2), lineWidth: 1.5))
    }
}


// MARK: - Recorder Button
struct RecorderButton: View{
    var body: some View{
        Button(action:{}){
            Text("Recorder Group")
                .font(.caption)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}

// MARK: - CONTENT PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
