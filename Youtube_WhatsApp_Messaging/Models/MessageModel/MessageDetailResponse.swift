//
//  MessageDetailResponse.swift
//  Youtube_WhatsApp_Messaging
//
//  Created by Sopheamen VAN on 19/7/24.
//

import Foundation

struct MessageDetailResponse: Hashable, Identifiable {
    var id: UUID
    var text: String
    var isMe: Bool
    var time: String
}
