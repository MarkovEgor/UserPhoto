//
//  ModelAlbum.swift
//  UserPhoto
//
//  Created by Egor Markov on 6/11/21.
//

import Foundation

struct AlbumUser: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
