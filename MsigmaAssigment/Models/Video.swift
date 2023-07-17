//
//  Video.swift
//  MsigmaAssigment
//
//  Created by Aaditya Singh on 16/07/23.
//

import Foundation

struct Video: Decodable, Identifiable {
  let id = UUID()
  let title: String
  let fileName: String
  let subtitle: String
  let remoteVideoURL: URL?

  private enum CodingKeys: String, CodingKey {
    case title, subtitle
    case fileName = "file_name"
    case remoteVideoURL = "remote_video_url"
  }
}

extension Video {
  var videoURL: URL? {
    return remoteVideoURL
  }
}





