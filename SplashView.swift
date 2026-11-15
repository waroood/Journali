//
//  SplashView.swift
//  Journali
//
//  Created by warood on 30/05/1448 AH.
//

import SwiftUI

struct SplashView: View {

    var body: some View {

        ZStack {

            // Background
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 12) {

                // Temporary Journal Illustration
                Image("JournalIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width:160, height:160)

                // App Name
                Text("Journali")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)

                // Subtitle
                Text("Your thoughts, your story")
                    .font(.system(size: 16))
                    .foregroundColor(.white)

            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SplashView()
}
