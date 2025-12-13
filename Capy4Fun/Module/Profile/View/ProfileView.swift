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
            ProfileImage(imageName: "mfdsix")
            
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
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 3)
            )
            .shadow(radius: 5)
    }
}
