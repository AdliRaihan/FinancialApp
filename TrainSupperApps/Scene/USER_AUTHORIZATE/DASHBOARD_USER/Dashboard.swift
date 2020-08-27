//
//  Dashboard.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 24/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct dashboardView: View {
    
    @State var appeared: Bool = false
    @State var menuSelected: Int = 0
    
    // Main
    var body: some View {
        NavigationView {
            VStack {
                if appeared {
                    VStack {
                        self.content.animation(nil).frame(maxHeight:.infinity)
                    }
                } else {
                    Spacer().onAppear {
                        print("Appeared")
                        self.appeared = true
                    }
                }
            }.onAppear {
                
            }.frame(maxWidth:.infinity, maxHeight: .infinity)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                HStack {
                    FinDefaultText("Repayment Plan", .bold, 17).foregroundColor(.getPrimaryDimmedColor)
                }
            )
        }
    }
    
    // Content
    private var content: some View {
        VStack(spacing: 0) {
            VStack(alignment:.leading) {
                ZStack {
                    HStack {
                        
                        VStack {
                            FinDefaultText("AR", .bold, 14).foregroundColor(.getLightWhiteColor)
                        }.frame(width: 20, height:20).padding()
                        
                        VStack(alignment: .leading) {
                            FinDefaultText("Bank PT. Theatrical Bits", .regular, 14).foregroundColor(.getLightWhiteColor)
                            HStack {
                                ForEach (0..<3) {
                                    index in
                                    HStack.init(alignment:.center) {
                                        ForEach (0..<5) {
                                            index in
                                            RoundedRectangle(cornerRadius: 2.5).size(width: 5, height: 5).foregroundColor(Color.getPrimaryDimmedColor.opacity(0.25))
                                        }
                                    }.frame(maxWidth: .infinity, maxHeight: 5, alignment: .center)
                                    HStack {
                                        Text("")
                                    }.frame(width: 10, height: 5, alignment: .center)
                                }
                                HStack {
                                    FinDefaultText("1234", .bold, 14).foregroundColor(.getPrimaryDimmedColor)
                                }
                            }
                        }.padding().frame(maxWidth: .infinity)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: Color.getGradientDeepSpace), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                }
                Spacer()
            }.frame(height:75).padding()

            HStack {
                VStack {
                    FinDefaultText("Plan", .bold, 14).foregroundColor(.getPrimaryDimmedColor).frame(maxWidth: .infinity, alignment: .center)
                    Rectangle().frame(maxWidth: (self.menuSelected == 0) ? .infinity : 0, maxHeight: 2).foregroundColor(.getDarkBlue)
                }.padding(0).onTapGesture {
                    self.menuSelected = 0
                }.transition(.slide).animation(.easeInOut(duration: 0.5))
                
                VStack {
                    FinDefaultText("Paid Bills", .bold, 14).foregroundColor(.getPrimaryDimmedColor).frame(maxWidth: .infinity, alignment: .center)
                    Rectangle().frame(maxWidth: (self.menuSelected == 1) ? .infinity : 0, maxHeight: 2).foregroundColor(.getDarkBlue)
                }.padding(0).onTapGesture {
                    self.menuSelected = 1
                }.transition(.slide).animation(.easeInOut(duration: 0.5))
                
                VStack {
                    FinDefaultText("History", .bold, 14).foregroundColor(.getPrimaryDimmedColor).frame(maxWidth: .infinity, alignment: .center)
                    Rectangle().frame(maxWidth: (self.menuSelected == 2) ? .infinity : 0, maxHeight: 2).foregroundColor(.getDarkBlue)
                }.padding(0).onTapGesture {
                    self.menuSelected = 2
                }.transition(.slide).animation(.easeInOut(duration: 0.5))
                    
            }.padding(EdgeInsets.init(top: 0, leading: 15, bottom: 0, trailing: 15))

            ZStack {
                self.unpaidBillsView.transition(.opacity)
                    .opacity((self.menuSelected == 0) ? 1 : 0).zIndex((self.menuSelected == 0) ? 1 : -1)
                    .animation(.easeInOut(duration: 0.25))
                self.paidBillsView.transition(.opacity).animation(nil)
                    .opacity((self.menuSelected == 1) ? 1 : 0).zIndex((self.menuSelected == 1) ? 1 : -1)
                    .animation(.easeInOut(duration: 0.25))
                self.historyPaidView.transition(.opacity).animation(nil)
                    .opacity((self.menuSelected == 2) ? 1 : 0).zIndex((self.menuSelected == 2) ? 1 : -1)
                    .animation(.easeInOut(duration: 0.25))
            }.frame(maxHeight: .infinity)
        }
    }
    
    var unpaidBillsView: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        // Repayment Due
                        VStack(alignment:.trailing) {
                            FinDefaultText("D U E", .light, 8).foregroundColor(.getPrimaryDimmedColor)
                            FinDefaultText("25.09.2020", .light, 14).foregroundColor(.getPrimaryDimmedColor)
                        }
                        
                        VStack(spacing:0) {
                            Rectangle.init().frame(maxWidth: 1, maxHeight: .infinity, alignment: .center).foregroundColor(Color.getPrimaryDimmedColor.opacity(0.25))
                        }.frame(width: 10)
                        
                        // Detailed
                        VStack {
                            FinDefaultText("Yearly Subscription Netflix", .regular, 14).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.getPrimaryDimmedColor)
                            Spacer().frame(height: 5)
                            VStack(alignment: .leading) {
                                FinDefaultText("Amount", .light, 14).foregroundColor(.getPrimaryDimmedColor)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                FinDefaultText("3.450.000 IDR", .bold, 16).foregroundColor(.getPrimaryDimmedColor)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                VStack(spacing: 0) {
                    HStack {
                        // Repayment Due
                        VStack(alignment:.trailing) {
                            FinDefaultText("D U E", .light, 8).foregroundColor(.getPrimaryDimmedColor)
                            FinDefaultText("31.08.2020", .light, 14).foregroundColor(.getPrimaryDimmedColor)
                        }
                        
                        VStack(spacing:0) {
                            Rectangle.init().frame(maxWidth: 1, maxHeight: .infinity, alignment: .center).foregroundColor(Color.getPrimaryDimmedColor.opacity(0.25))
                        }.frame(width: 10)
                        
                        // Detailed
                        VStack {
                            FinDefaultText("Monthly Subscription Indihome", .regular, 14).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.getPrimaryDimmedColor)
                            Spacer().frame(height: 5)
                            VStack(alignment: .leading) {
                                FinDefaultText("Amount", .light, 14).foregroundColor(.getPrimaryDimmedColor)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                FinDefaultText("1.024.000 IDR", .bold, 16).foregroundColor(.getPrimaryDimmedColor)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
        }.animation(nil)
    }
    
    var paidBillsView: some View {
        VStack {
            ForEach (0..<5) {
                _ in
                VStack {
                    HStack {
                        VStack {
                            FinDefaultText("800.000 IDR", .bold, 22).frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.getDarkBlue)
                            HStack {
                                FinDefaultText("31 August 2020", .regular, 12).frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.getPrimaryDimmedColor)
                                FinDefaultText("3 Days Remaining", .regular, 12).frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(.getPrimaryDimmedColor)
                            }
                        }
                    }.padding()
                }
            }
        }.animation(nil)
    }
    
    var historyPaidView: some View {
        VStack {
            ForEach (0..<5) {
                _ in
                VStack {
                    HStack {
                        VStack {
                            FinDefaultText("705.000 IDR", .bold, 22).frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.getDarkBlue)
                            HStack {
                                FinDefaultText("31 August 2020", .regular, 12).frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.getPrimaryDimmedColor)
                                FinDefaultText("3 Days Remaining", .regular, 12).frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(.getPrimaryDimmedColor)
                            }
                        }
                    }.padding()
                }
            }
        }
    }
}

class dashboardViewBusiness: ObservableObject {
    
    // final
    final let wallet: Int = 100000
    @Published var currentWallet: Int = 0
    
    func classCalculateTotalWallet() {
    }
}
