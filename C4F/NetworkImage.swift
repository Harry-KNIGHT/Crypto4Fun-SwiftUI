//
//  NetworkImage.swift
//  C4F
//
//  Created by Elliot Knight on 07/12/2022.
//

import SwiftUI

struct NetworkImage: View {
    let url: URL?

    var body: some View {
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
					.frame(width: 35, height: 35)
            }
            else {
                ProgressView()
            }
        }
    }
}
