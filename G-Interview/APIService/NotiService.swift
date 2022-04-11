//
//  NotiService.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import Foundation

struct NotiService: APIService {
    var baseUrl: String = "https://raw.githubusercontent.com/phthphat-interview/g-group/main"
    
    func getNotiList(handler: @escaping HandleAPIModel<[NotiModel]>) {
        self.request(
            EndPoint(
                path: "/noti.json",
                method: .get,
                param: [:]
            ),
            handler: handler
        )
    }
}

struct NotiModel: Decodable {
    @Missable var id: String
    @Missable var message: Message
    @Missable var image: String?
    @Missable var icon: String?
    @Missable var readAt: Int
    
    struct Message: Decodable, DefaultDecodable {
        static var defaultDecodeValue: NotiModel.Message = .init(text: "", highlights: [])
        
        var text: String
        var highlights: [Offset]
    }
}


struct Offset: Decodable, DefaultDecodable {
    var offset: Int
    var length: Int
    
    static var defaultDecodeValue: Offset = .init(offset: 0, length: 0)
}
