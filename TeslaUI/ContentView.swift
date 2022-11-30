//
//  ContentView.swift
//  TeslaUI
//
//  Created by Thuta sann on 11/30/22.
//

import SwiftUI


// MARK: - MAIN CONTENT VIEW FOR HOME SCREEN
struct ContentView: View {
    var body: some View {
        ZStack{
                
            ScrollView{
                VStack(spacing: 20){
                    HomeHeader()
                    CustomDivider()
                    CarSection()
                    CustomDivider()
                    CategoryView(title: "Quick Shortcuts", showEdit: true, actionItems: quickShortcuts)
                    CustomDivider()
                    CategoryView(title: "Recent Actions", showEdit: true, actionItems: recentShortcuts)
                    CustomDivider()
                    AllSettings()
                    RecorderButton()
                }
                .padding()
            }
            
            VoiceCommandButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DrakGray"))
        .foregroundColor(Color.white)
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


// MARK: - Header Buttons
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

// MARK: - Car Section
struct CarSection: View{
    var body: some View{
        VStack (spacing:10){
            HStack(alignment: .center){
                HStack{
                    Image(systemName: "battery.75")
                    Text("237 miles".uppercased())
                }
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("Green"))
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
    
    var title: String
    var showEdit: Bool = false
    
    var actionItems: [ActionItem]
    
    var body: some View{
        VStack{
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false){
                HStack (alignment: .top){
                    ForEach(actionItems, id:\.self){ item in
                        ActionButton(item: item)
                    }
                }
            }
        }
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

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Charging"),
    ActionItem(icon: "fanblades.fill", text: "Fan on"),
    ActionItem(icon: "play.fill", text: "Media"),
    ActionItem(icon: "bolt.car", text: "Charge Port")
]


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
                SettingBlock(icon: "car.fill", title: "Controls", subtitle: "CAR CONTROL", hasSubtitle: true)
                SettingBlock(icon: "fanblades.fill", title: "Climate", subtitle: "Interior 68° F", hasSubtitle: true, backgroundColor: Color.blue)
                SettingBlock(icon: "location.fill",  title: "Location", subtitle: "EMPIRE STATE BUILDING", hasSubtitle: true)
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
        .padding()
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
