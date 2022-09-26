//
//  HomeView.swift
//  SaudiMarch
//
//  Created by MacBook pro on 21/09/2022.
//

import SwiftUI

struct HomeView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    @State private var searchText = ""
    @State var didAppear = false
    
    var body: some View {
//        homeViewBody
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHGrid(rows: hColumns, alignment: .center, spacing: 0) {
//                    GridRow {
                        ForEach((0...10), id: \.self) { item in
                            
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .font(.system(size: 100))
                                Text("Hello")
                            }.background(.brown)
                                .cornerRadius(10)
                            
                            
                            //                            RoundedRectangle(cornerRadius: 10)
                            //                                .stroke(.green, lineWidth: 2)
                            //                                .background(.blue)
                            //                                .frame(width: 200)
                        }
                    //                    }.background(.yellow)
                }.frame(height: 300)
            }
            .frame(width: proxy.size.width)
            .background(.red)
        }
    }
    
    let hColumns: [GridItem] = [
        .init(.adaptive(minimum: 50), spacing: 0, alignment: .top),
        .init(.adaptive(minimum: 50), spacing: 0, alignment: .top),
    ]
    
    let columns: [GridItem] = [
        .init(.flexible(), spacing: 10, alignment: .center),
        .init(.flexible(), spacing: 10, alignment: .center),
    ]
    
    var homeViewBody: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    GridRow {
                        Section {
                            ForEach((0...10), id: \.self) { id in
                                cellView
                            }.buttonStyle(.plain)
                            
                        } header: {
                            HStack {
                                Text("Newly added")
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("View all")
                                }
                            }.padding(.horizontal, 5)
                        }
                    }
                }
            }
            .navigationTitle("")
            .searchable(text: $searchText)
            .onSubmit(of: .search, { print(searchText) })
            .onChange(of: searchText, perform: { newValue in
                print(searchText)
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "square.and.arrow.up.fill")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up.fill")
                    }
                }
            }
        }
    }
    
    var cellView: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationLink {
                SigninView()
            } label: {
                VStack {
                    ZStack(alignment: .topLeading) {
                        Image("logo")
                            .resizable()
                            .frame(height: 200)
                        Text("30% off")
                            .padding(.all, 5)
                            .background(.green)
                            .cornerRadius(10)
                    }
                    .cornerRadius(10)
                    Text("Jacket")
                        .font(.system(.headline))
                    Text("ZARA")
                    HStack {
                        Text("100 SR")
                        Spacer()
                    }
                }
            }
            Button {
                print("add to fav")
            } label: {
                Image(systemName: "suit.heart.fill")
                    .tint(.red)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
