//
//  CapybaraFavRow.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI
import SDWebImageSwiftUI
import CachedAsyncImage

struct CapybaraFavRow: View {

  var capybara: CapybaraModel

  private let rowHeight: CGFloat = 80

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      imageThumbnail
      VStack(alignment: .leading, spacing: 4) {
        Text(capybara.title)
          .font(.headline)
          .lineLimit(1)
        Text(capybara.description)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .lineLimit(2)
      }
      .padding(.vertical, 8)

      Spacer()
    }
    .frame(height: rowHeight)
    .overlay(
        RoundedRectangle(cornerRadius: 2)
            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
    )
    .padding(.horizontal)
    .padding(.vertical, 5)
  }

  private var imageThumbnail: some View {
    Group {
      if #available(iOS 15.0, *) {
        AsyncImage(url: URL(string: capybara.image)) { image in
          image.resizable()
            .scaledToFill()
        } placeholder: {
          ProgressView()
        }
      } else {
        WebImage(url: URL(string: capybara.image))
          .resizable()
          .indicator(.activity)
          .transition(.fade(duration: 0.5))
          .scaledToFill()
      }
    }
    .frame(width: rowHeight, height: rowHeight)
    .clipped()
  }
}

struct CapybaraFavoriteRow_Previews: PreviewProvider {

  static var previews: some View {
    let dummyCapybara = CapybaraModel(
      id: "1",
      title: "Capy #0001",
      image: "http://api.capy.lol/v1/capybara/1",
      description: "Deskripsi singkat tentang capybara",
      isFavorite: true
    )

    List {
        CapybaraFavRow(capybara: dummyCapybara)
        CapybaraFavRow(capybara: dummyCapybara)
    }
    .listStyle(.plain)
  }
}
