//
//  CreateGroup.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 28/09/25.
//

import SwiftUI
import PhotosUI
import Combine

final class CreateGroupViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var selectedImage: UIImage?
    
    func buildGroup() -> GroupDisplayItem {
        GroupDisplayItem(id: 10, icon: "", name: name, image: Image(uiImage: selectedImage ?? UIImage()), status: .noExpense)
    }
}

struct CreateGroup: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var showPicker: Bool = false

    @ObservedObject private var viewModel = CreateGroupViewModel()

    @Environment(\.dismiss) var dismiss

    var onSave: (GroupDisplayItem) -> Void

    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    GroupImageButton(selectedImage: $selectedImage, showPicker: $showPicker)
                    GroupNameField(name: $viewModel.name)
                }
                .photosPicker(isPresented: $showPicker, selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            viewModel.selectedImage = uiImage
                        }
                    }
                }                .padding()
                .navigationTitle("Add a new Group")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            let group = viewModel.buildGroup()
                                onSave(group)
                                dismiss()
                        }
                        .bold()
                    }
                }
                VStack(alignment: .leading){
                    
                    Text("Type")
                        .font(.title3)
                    
                    IconGrid()
                }
                .padding()
                Spacer()
                
            }
            .background{
                Color(.systemBackground)
            }
        }
    }
}

struct GroupImageButton: View {
    @Binding var selectedImage: Image?
    @Binding var showPicker: Bool

    var body: some View {
        Button(action: { showPicker = true }) {
            if let selectedImage = selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

struct GroupNameField: View {
    @Binding var name: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Group Name")
                .font(.headline)

            TextField("Swiss Trip", text: $name)
                .font(.default)

        }
        .padding()
    }
}

#Preview {
    CreateGroup{
        _ in Text("Preview")
    }
}

struct GroupTypeDisplayable: Identifiable {
    let id = UUID()
    var type: GroupType
    let systemName: String
    let description: String
}

enum GroupType: String, CaseIterable {
    case trip
    case couple
    case friends
    case others
    case home
}

struct IconGrid: View {
    let icons: [GroupTypeDisplayable] = [
        .init(type: .home, systemName: "house", description: "Home"),
        .init(type: .trip, systemName: "airplane.departure", description: "Trip"),
        .init(type: .couple, systemName: "heart", description: "Couple"),
        .init(type: .friends, systemName: "person.2", description: "Friends"),
        .init(type: .others, systemName: "plus", description: "Others"),
    ]
    
    let rows = [
        GridItem(.fixed(100))
    ]
    
    @State private var selectedIconID: UUID?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(icons) { icon in
                    VStack {
                        Image(systemName: icon.systemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .foregroundColor(.white)
                            .background(.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Text(icon.description)
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    .frame(width: 100, height: 100)
                    .background(Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                            selectedIconID == icon.id ? .red : Color(.label),
                            lineWidth: 2
                        )
                    )
                    .onTapGesture {
                        selectedIconID = icon.id
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    IconGrid()
}
