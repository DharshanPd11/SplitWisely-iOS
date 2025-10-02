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
    @Published var selectedGroupType: GroupType = .none
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    
    func selectGroupType(_ type: GroupType) {
        selectedGroupType = type
    }
    
    func buildGroup() -> GroupDisplayItem {
        GroupDisplayItem(id: 10, icon: "", name: name, image: Image(uiImage: selectedImage ?? UIImage()), status: .noExpense)
    }
}

struct CreateGroup: View {
    
    @State private var selectedImage: Image? = nil    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var showPicker: Bool = false

    @ObservedObject private var viewModel = CreateGroupViewModel()

    @Environment(\.dismiss) var dismiss

    var onSave: (GroupDisplayItem) -> Void

    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    GroupImageButton(selectedImage: $viewModel.selectedImage, showPicker: $showPicker)
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
                    
                    IconGrid(selectedGroupType: $viewModel.selectedGroupType)
                }
                .padding()
                Spacer()
                
            }
            .background{
                Color(.systemBackground)
            }
        }
        .environmentObject(viewModel)
    }
}

struct GroupImageButton: View {
    @Binding var selectedImage: UIImage?
    @Binding var showPicker: Bool

    var body: some View {
        Button(action: { showPicker = true }) {
            if let uiImage = selectedImage {
                Image(uiImage: uiImage)
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

struct IconGrid: View {
    @Binding var selectedGroupType: GroupType
    
    let icons: [GroupTypeDisplayable] = [
        .init(type: .home, systemName: "house", description: "Home"),
        .init(type: .trip, systemName: "airplane.departure", description: "Trip"),
        .init(type: .couple, systemName: "heart", description: "Couple"),
        .init(type: .friends, systemName: "person.2", description: "Friends"),
        .init(type: .others, systemName: "plus", description: "Others"),
    ]
    let rows = [ GridItem(.fixed(100)) ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(icons) { icon in
                    VStack {
                        Image(systemName: icon.systemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.top)
                            .foregroundColor(.secondary)
                            .background(.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Text(icon.description)
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                selectedGroupType == icon.type ? .red : Color(.label),
                                lineWidth: 2
                            )
                    )
                    .onTapGesture {
                        if selectedGroupType == icon.type {
                            selectedGroupType = .none
                        } else {
                            selectedGroupType = icon.type
                        }
                    }
                }
            }
            .padding()
        }
        GroupTypeDetailView(type: selectedGroupType)
            .id(selectedGroupType)
            .cornerRadius(12)
            .animation(.smooth, value: selectedGroupType)
    }
}

#Preview {
    @ObservedObject var viewModel = CreateGroupViewModel()

    IconGrid(selectedGroupType: $viewModel.selectedGroupType)
        .environmentObject(viewModel)

}
