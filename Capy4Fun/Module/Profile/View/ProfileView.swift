//
//  ProfileView.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI

struct ProfileView: View {

    var body: some View {
        VStack(spacing: 30) {
            ProfileImage(imageURL: "https://assets.cdn.dicoding.com/small/avatar/dos:8b98b613297963f528baa60c023deb3020211008131122.png")

            VStack(spacing: 8) {
                Text("Mahfudz Ainur Rif'an")
                    .font(.title)
                    .bold()

                Text("Expert iOS Developer")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.top, 50)
        .navigationTitle("About Me")
    }
}

struct ProfileImage: View {
    var imageURL: String

    var body: some View {
        Group {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                            .resizable()
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 150, height: 150)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 3) // Garis luar tipis
        )
        .shadow(radius: 5)
    }
}
