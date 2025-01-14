//
//  StarsView.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/15/25.
//

import SwiftUI

struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
            }
        }

        stars.overlay {
            GeometryReader { geometry in
                let width = rating / CGFloat(maxRating) * geometry.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        }
        .foregroundColor(.gray.opacity(0.3))
    }
}

#Preview {
    StarsView(rating: 2.5, maxRating: 5)
}
