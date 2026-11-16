
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
            JournaliColors.background
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Image("JournalIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.bottom, 4)

                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .foregroundStyle(JournaliColors.primaryText)

                Text("Your thoughts, your story")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(JournaliColors.primaryText)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
        //.preferredColorScheme(.dark)
    }
}

#Preview {
    SplashView()
}
