//
//  MessageView.swift
//  Youtube_WhatsApp_Messaging
//
//  Created by Sopheamen VAN on 19/7/24.
//

import SwiftUI

struct MessageView: View {
    @State private var textFieldSearch = ""
    
    // custom tab
    // default tab
    @State private var selectedTab = "Focused"
    // two tabs header
    let tabs = ["Focused", "Other"]
    // namespace for animating tab
    @Namespace private var underlineNamespace
    // get size width of the screen and by 2
    let width = (UIScreen.main.bounds.width / 2)
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // content tab and content here
                // tab header
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Button{
                            // set state and animate
                            withAnimation {
                                selectedTab = tab
                            }
                        }label: {
                            Text(tab)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(selectedTab == tab ? Color.activeGreenTab : .black.opacity(0.6))
                                .padding(.bottom, 12)
                                .overlay(
                                    selectedTab == tab ?
                                    Rectangle()
                                        .frame(width: width, height:2)
                                        .foregroundStyle(Color.activeGreenTab)
                                        .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                                    : nil,
                                    alignment: .bottom
                                )
                        }
                        .frame(width: width)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55, alignment: .leading)
                .background(.white)
                
                // tab content
                getContentTab(value: selectedTab)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.backgroundColor)
            .toolbar {
                // leading icon button
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        // action here
                    }label: {
                        // layout or icon content
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                            .foregroundStyle(.black.opacity(0.8))
                    }
                }
                // textfield center
                ToolbarItem (placement: .principal){
                    HStack (spacing: 10){
                        // content of custom text field
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.5))
                        // textfield
                        TextField("Search messages..",text: $textFieldSearch)
                        
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.8))
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 35)
                    .background(Color.textFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 8)
                }
                // traling icon button
                ToolbarItem (placement: .topBarTrailing){
                    HStack {
                        Button {
                            // action here
                        }label: {
                            // layout or icon content
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        .padding(.trailing, 10)
                        
                        Button {
                            // action here
                        }label: {
                            // layout or icon content
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 23, height: 23)
                                .foregroundStyle(.black.opacity(0.8))
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
        }
    }
    
    // func to get the content of the tab
    @ViewBuilder
    func getContentTab(value: String) -> some View {
        switch value {
        case "Focused":
            FocusedView()
        case "Other":
            OtherView()
        default:
            EmptyView()
        }
    }
}

#Preview {
    MessageView()
}

struct FocusedView: View {
    var messagesDatas:[MessageResponse] = messagesData
    var body: some View {
        // fetch all datas from dummy
        LazyVStack {
            ForEach(messagesDatas) { message in
                NavigationLink(destination:  MessageDetailView(message: message)){
                    MessageRowView(message: message)
                }
            }
        }
        .padding(.vertical,10)
        .padding(.horizontal)
        .background(.white)
        
    }
}

struct MessageRowView: View {
    var message: MessageResponse
    var body: some View {
        HStack {
            HStack (spacing: 12){
                ProfileImageView(profileImage: message.user.profileImage, size: 55)
                VStack (alignment: .leading, spacing:0){
                    Text(message.user.fullname)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black)
                    Text(message.text)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .fontWeight(message.badgeNumber != 0 ? .semibold : .regular)
                        .lineLimit(1)
                    Divider()
                        .padding(.top, 5)
                }
            }
            // spacing
            Spacer()
            
            VStack (spacing: 8){
                Text(message.dateAgo)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.7))
                if (message.badgeNumber != 0), message.badgeNumber > 0 {
                    ZStack {
                        Circle()
                            .fill(Color.primaryColor)
                            .frame(width: 20, height: 20)
                        Text("\(message.badgeNumber)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
            }
            
        }
    }
}

struct OtherView: View {
    var body: some View {
        VStack (spacing: 30){
            Image("empty_state")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
            
            VStack (spacing: 12){
                Text("No messages - yet!")
                    .font(.title2)
                Text("Reach out and start a conversation. Great things might happen.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                
                Button {
                    
                }label: {
                    Text("Start a new message")
                        .font(.subheadline)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
                }
            }
        }
        .padding(.top,100)
    }
}
