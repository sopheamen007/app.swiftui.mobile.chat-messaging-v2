//
//  MessageDetailView.swift
//  Youtube_WhatsApp_Messaging
//
//  Created by Sopheamen VAN on 19/7/24.
//

import SwiftUI

struct MessageDetailView: View {
    var message: MessageResponse
    // back button trigger
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // content chat history
                ScrollView (showsIndicators: false){
                    VStack (spacing: 20){
                        // header
                        ProfileHederView(message: message)
                        
                        // chat bubble
                        ChatHistoryView(message: message)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 100)
                .padding(.horizontal)
                
                // footer
                FooterView()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(.white)
            .toolbar {
                // leading content
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button {
                            dismiss()
                        }label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 17, height: 17)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        
                        // fullname text
                        Text(message.user.fullname)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                
                // traling content
                ToolbarItem(placement: .topBarTrailing) {
                    HStack (spacing:15){
                        Button {
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        Button {
                            
                        }label: {
                            Image(systemName: "video.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        Button {
                            
                        }label: {
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                      
                    }
                }
            }
        }
    }
}

#Preview {
    MessageDetailView(message: messagesData[0])
}

struct ProfileHederView:View {
    var message: MessageResponse
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            ProfileImageView(profileImage: message.user.profileImage, size: 70)
            HStack (spacing: 0){
                Text(message.user.fullname)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(" - 2nd")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.8))
            }
            Text("\(message.user.headLineBio) At \(message.user.companyLocation ?? "")")
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatHistoryView: View {
    // get from the main chat screen
    var message: MessageResponse
    // load message conversation
    var messageDetailDatas: [MessageDetailResponse] = messagesDetailData
    var body: some View {
        VStack (spacing: 20){
            // add saturday line
            HStack {
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                Spacer()
                Text("Saturday")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.5))
                    .textCase(.uppercase)
                Spacer()
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
            }
            
            // content chat here
            LazyVStack (spacing: 20){
                ForEach(messageDetailDatas) { messageDetail in
                    MessageConversationRowView(message: message, messageDetail: messageDetail)
                }
            }
            
            // chat buttons
            HStack (spacing: 12){
                Button {
                    
                }label: {
                    Text("You're welcome")
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
                }
                Button {
                    
                }label: {
                    Text("My pleasure")
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
                }
            }
            
            
        }
    }
}

struct MessageConversationRowView: View {
    var message: MessageResponse
    var messageDetail: MessageDetailResponse
    var body: some View {
        HStack (alignment: .top, spacing: 12){
            ProfileImageView(profileImage: messageDetail.isMe ? userDataCurrent.profileImage : message.user.profileImage,size: 40)
                .padding(.top, 5)
            VStack (alignment: .leading){
                HStack (spacing: 0){
                    Text(messageDetail.isMe ? userDataCurrent.fullname : message.user.fullname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(" - \(messageDetail.time)")
                        .font(.footnote)
                        .foregroundStyle(.black.opacity(0.7))
                }
                // text here
                Text(messageDetail.text)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct FooterView: View {
    @State private var sendMessage = ""
    var body: some View {
        HStack {
            HStack {
                Button {
                    
                }label: {
                    Image(systemName: "paperclip")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 19, height:19)
                        .foregroundStyle(.black.opacity(0.8))
                        .fontWeight(.semibold)
                }
                // textfield send message
                TextField("Write a message...",text: $sendMessage)
                    .padding(.horizontal,10)
                    .frame(height: 40)
                    .background(Color.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal,8)
                
                Button {
                    
                }label: {
                    Image(systemName: "mic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16, height:16)
                        .foregroundStyle(.black.opacity(0.8))
                        .fontWeight(.semibold)
                }
                
            }
            .padding(.top, -20)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(.white)
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.15)))
    }
}
