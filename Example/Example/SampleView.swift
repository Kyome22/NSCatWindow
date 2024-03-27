/*
 SampleView.swift
 Example

 Created by Takuto Nakamura on 2024/03/27.
 
*/

import SwiftUI

struct SampleView: View {
    @State var inputText: String = ""

    var body: some View {
        TextEditor(text: $inputText)
            .frame(
                minWidth: 300,
                maxWidth: .infinity,
                minHeight: 100,
                maxHeight: .infinity
            )
            .padding(8)
    }
}

#Preview {
    SampleView()
}
