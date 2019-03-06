//
//  commentObject.swift
//  MockSpot
//
//  Created by Nick John on 2/16/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import Foundation

class Comment {
    
    var user: String
    var commentBody: String
    var time: Date
    var isCertifiedDidNav: Bool
    
    init(user: String, commentBody: String, time: Date, didNavTo: Bool) {
        self.user = user
        self.commentBody = commentBody
        self.time = time
        self.isCertifiedDidNav = didNavTo
    }
    
}
