//
//  MessageResponse.swift
//  Youtube_WhatsApp_Messaging
//
//  Created by Sopheamen VAN on 19/7/24.
//

import Foundation

struct MessageResponse: Identifiable, Hashable {
    var id: UUID
    var user: UserLinkedInResponse
    var text: String
    var badgeNumber: Int // 0 is nil, has more than 0
    var dateAgo: String // 8:35 am, 9:00 am, Mon, Tue, Apr 12
}
