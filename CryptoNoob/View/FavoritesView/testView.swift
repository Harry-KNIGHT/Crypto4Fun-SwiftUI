//
//  testView.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import SwiftUI
import SwipeActions

struct testView: View {
    var body: some View {
		ScrollView {
				   LazyVStack {
					   ForEach(1...100, id: \.self) { cell in
						   Text("Cell \(cell)")
							   .frame(height: 50, alignment: .center)
							   .frame(maxWidth: .infinity)
							   .contentShape(Rectangle())
							   .addSwipeAction (edge: .leading) {
								   Button {
									   print("remove \(cell)")
								   } label: {
									   Image(systemName: "trash")
										   .foregroundColor(.white)
								   }
								   .frame(width: 60, height: 50, alignment: .center)
								   .contentShape(Rectangle())
								   .background(Color.red)

								   Button {
									   print("Inform \(cell)")
								   } label: {
									   Image(systemName: "bell.slash.fill")
										   .foregroundColor(.white)
								   }
								   .frame(width: 60, height: 50, alignment: .center)
								   .background(Color.blue)

							   }
					   }
				   }
			   }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
