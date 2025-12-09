//
//  CapybaraRow.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI
import SDWebImageSwiftUI
import CachedAsyncImage

struct CapybaraRow: View {

  var capybara: CapybaraModel

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      imageThumbnail
        .padding(.bottom, 8)
      contentHeader
      contentDescription
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
  }

  private var imageThumbnail: some View {
    GeometryReader { proxy in
      let cardWidth = proxy.size.width
      let imageStandardHeight: CGFloat = 300

      Group {
        if #available(iOS 15.0, *) {
          AsyncImage(url: URL(string: capybara.image)) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            ProgressView()
              .frame(width: cardWidth, height: imageStandardHeight)
              .background(Color.gray.opacity(0.1))
          }
        } else {
          WebImage(url: URL(string: capybara.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
        }
      }
      .frame(width: cardWidth, height: imageStandardHeight)
      .clipped()
    }
    .frame(height: 300)
  }

  private var contentHeader: some View {
    HStack {
      Text(capybara.title)
        .font(.headline)
        .bold()

      Spacer()

      Image(systemName: capybara.isFavorite ? "heart.fill" : "heart")
        .foregroundColor(capybara.isFavorite ? .red : .gray)
        .font(.title2)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
  }

  private var contentDescription: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(capybara.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .lineLimit(2)
    }
    .padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 12,
        trailing: 16
      )
    )
  }
}

struct CategoryRow_Previews: PreviewProvider {

  static var previews: some View {
    let meal = CapybaraModel(
      id: "1",
      title: "Capy #0001",
      image: "https://api.capy.lol/v1/capybara/1",
      description: "a capybara",
      isFavorite: false
    )

    ScrollView {
      CapybaraRow(capybara: meal)
      CapybaraRow(capybara: meal)
    }
    .padding(.horizontal, 0)
  }
}
