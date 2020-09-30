//
//  Dashboard.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 24/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore


struct dashboardView: View {
    
    @State var appeared: Bool = false
    @State var menuSelected: Int = 0
    @State var profileMenuOpen: Bool = false
    
    // Main
    var body: some View {
        NavigationView {
            VStack {
                if appeared {
                    ZStack {
                        VStack {
                            self.content.animation(nil).frame(maxHeight:.infinity)
                        }
                        
                        if profileMenuOpen {
                            ScrollView {
                                VStack {
                                    Button.init(action: {
                                        try! Auth.auth().signOut()
                                    }) {
                                        FinDefaultText.init("Logout", .bold, 14)
                                    }
                                }.animation(nil)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white).animation(.easeInOut(duration: 0.25))
                        }
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
                    FinDefaultText("Hi,", .regular, 14).foregroundColor(.white)
                    FinDefaultText("Adli Raihan !", .bold, 14).foregroundColor(.white)
                    Image("ic_drop_down").resizable().renderingMode(.template).frame(width: 10, height: 10, alignment: .center).foregroundColor(.white)
                }.onTapGesture {
                    self.profileMenuOpen.toggle()
                }, trailing:
                
                GeometryReader.init(content: { (reader) in
                    ZStack {
                        Image.init("ic_notifications").resizable().renderingMode(.template).antialiased(true).frame(width: 25, height: 25, alignment: .center).foregroundColor(.white)
                        RoundedRectangle.init(cornerRadius: 3.25).frame(width: 7.5, height: 7.5, alignment: .topTrailing).offset(x: reader.size.width - 5, y: -reader.size.height + 5).foregroundColor(.white)
                    }
                })
            )
        }
    }
    
    // Content
    private var content: some View {
        VStack(spacing: 0) {
            
            ScrollView {
                VStack(alignment:.leading) {
                    ZStack {
                        HStack {
                            
                            VStack {
                                FinDefaultText("AR", .bold, 14).foregroundColor(.getLightWhiteColor)
                            }.frame(width: 20, height:20).padding()
                            
                            VStack(alignment: .leading) {
                                FinDefaultText("iOS Developer", .regular, 14).foregroundColor(.getLightWhiteColor)
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
                }.frame(height:75).padding().background(Color.getLightWhiteColor)
                
                VStack {
                    FinDefaultText("Quick Offer", .bold, 16).foregroundColor(.getPrimaryDimmedColor)
                    FinDefaultText("Swipe For More", .light, 10).foregroundColor(.getPrimaryDimmedColor)
                }.padding()
                ScrollView.init(.horizontal, showsIndicators: false) {
                    HStack {
                        ZStack {
                            self.featuredBookings
                                .animation(nil)
                        }.frame(maxWidth: screenBounds.size.width, maxHeight: .infinity)
                        ZStack {
                            self.featuredBookings
                                .animation(nil)
                        }.frame(maxWidth: screenBounds.size.width, maxHeight: .infinity)
                    }
                }
                
                VStack {
                    FinDefaultText("Statistics", .bold, 16).foregroundColor(.getPrimaryDimmedColor)
                }.padding()
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment:.leading) {
                        FinDefaultText("Est. Total Revenue", .light, 14).foregroundColor(.getSecondaryColor)
                        HStack {
                            FinDefaultText("$", .bold, 14).foregroundColor(.getSecondaryColor)
                            FinDefaultText("1,738,293.00", .bold, 14).foregroundColor(.getSecondaryColor)
                        }
                    }.padding()
                    
                    VStack(alignment:.leading) {
                        FinDefaultText("Projects Taken", .light, 14).foregroundColor(.getSecondaryColor)
                        FinDefaultText("80/100", .bold, 14).foregroundColor(.getSecondaryColor)
                        ZStack(alignment: .leading) {
                            RoundedRectangle.init(cornerRadius: 5).foregroundColor(.getPrimaryDimmedColor).frame(height:10)
                            RoundedRectangle.init(cornerRadius: 5).foregroundColor(.getSecondaryColor).frame(width: 50, height:10)
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    
                    VStack(alignment:.leading) {
                        FinDefaultText("Finished Projects", .light, 14).foregroundColor(.getSecondaryColor)
                        FinDefaultText("54/80", .bold, 14).foregroundColor(.getSecondaryColor)
                        ZStack(alignment: .leading) {
                            RoundedRectangle.init(cornerRadius: 5).foregroundColor(.getPrimaryDimmedColor).frame(height:10)
                            RoundedRectangle.init(cornerRadius: 5).foregroundColor(.getSecondaryColor).frame(width: 50, height:10)
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    
                    VStack(alignment:.leading) {
                        FinDefaultText("Postponed Projects", .light, 14).foregroundColor(.getSecondaryColor)
                        FinDefaultText("26/80", .bold, 14).foregroundColor(.getSecondaryColor)
                        ZStack(alignment: .leading) {
                            RoundedRectangle.init(cornerRadius: 5).foregroundColor(.getPrimaryDimmedColor).frame(height:10)
                            RoundedRectangle.init(cornerRadius: 5).foregroundColor(.getSecondaryColor).frame(width: 50, height:10)
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    
                }.padding().frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(Color.getLightWhiteColor)
    }
    
    var featuredBookings: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image.init("ic_customer").resizable().renderingMode(.template).frame(width: 15, height: 15, alignment: .center).foregroundColor(.getPrimaryDimmedColor)
                    VStack(alignment: .leading) {
                        FinDefaultText("Name", .light, 12).foregroundColor(.getPrimaryDimmedColor)
                        FinDefaultText("Adli Raihan", .bold, 12).foregroundColor(.getSecondaryColor)
                    }
                }
                HStack(alignment: .center) {
                    Image.init("ic_calendar").resizable().renderingMode(.template).frame(width: 15, height: 15, alignment: .center).foregroundColor(.getPrimaryDimmedColor)
                    VStack(alignment: .leading) {
                        FinDefaultText("When", .light, 12).foregroundColor(.getPrimaryDimmedColor)
                        FinDefaultText("Tuesday, 31 February 2021 at 11 am", .bold, 12).foregroundColor(.getSecondaryColor)
                    }
                }
                HStack(alignment: .center) {
                    Image.init("ic_duration").resizable().renderingMode(.template).frame(width: 15, height: 15, alignment: .center).foregroundColor(.getPrimaryDimmedColor)
                    VStack(alignment: .leading) {
                        FinDefaultText("Duration", .light, 12).foregroundColor(.getPrimaryDimmedColor)
                        FinDefaultText("8 Months", .bold, 12).foregroundColor(.getSecondaryColor)
                    }
                }
                HStack(alignment: .center) {
                    Image.init("ic_email").resizable().renderingMode(.template).frame(width: 15, height: 15, alignment: .center).foregroundColor(.getPrimaryDimmedColor)
                    VStack(alignment: .leading) {
                        FinDefaultText("E-mail Address", .light, 12).foregroundColor(.getPrimaryDimmedColor)
                        FinDefaultText("adli.raihan@gmail.com", .bold, 12).foregroundColor(.getSecondaryColor)
                    }
                }
                HStack(alignment: .center) {
                    Image.init("ic_check_box").resizable().renderingMode(.template).frame(width: 15, height: 15, alignment: .center).foregroundColor(.getPrimaryDimmedColor)
                    VStack(alignment: .leading) {
                        FinDefaultText("Status", .light, 12).foregroundColor(.getPrimaryDimmedColor)
                        FinDefaultText("Waiting for response", .bold, 12).foregroundColor(.getSecondaryColor)
                    }
                }
                Spacer().frame(width: 1, height: 10, alignment: .center)
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        FinDefaultText("Additional Notes", .light, 12).foregroundColor(.getPrimaryDimmedColor)
                        FinDefaultText("I Need you to build an App using firebase and websocket to make chatting application.", .bold, 12).foregroundColor(.getSecondaryColor).lineLimit(4)
                    }.frame(height: 75, alignment: .bottomLeading)
                }
                Spacer().frame(width: 1, height: 10, alignment: .center)
                HStack(alignment: .top) {
                    Button.init(action: {
                        
                    }) {
                        VStack {
                            FinDefaultText.init("More Details", .regular, 14)
                        }
                    }.foregroundColor(.white).padding(EdgeInsets.init(top: 10, leading: 25, bottom: 10, trailing: 25)).background(Color.getPrimaryColor)
                    Spacer()
                    Button.init(action: {
                        
                    }) {
                        VStack {
                            FinDefaultText.init("Decline", .regular, 14)
                        }
                    }.foregroundColor(.getPrimaryColor).padding(EdgeInsets.init(top: 10, leading: 25, bottom: 10, trailing: 25)).background(Color.white)
                }
            }.padding().background(Color.white)
        }.padding(EdgeInsets.init(top: 5, leading: 50, bottom: 5, trailing: 50))
    }
    
    // Mock Data
    var unpaidBillsData: [String:Any] = [
        "transactions" : [
            "nameProducts":"NETFLIX",
            "productType":"Subscription",
            "productAmount": 4000000,
            "productSeller": 12,
        ]
    ]
    var productsLists: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    HStack {
                        FinDefaultText("Active", .bold, 14).foregroundColor(.getPrimaryColor)
                        Image("ic_drop_down").resizable().antialiased(true).frame(width: 10, height: 10, alignment: .center)
                        Spacer()
                    }
                }.frame(maxHeight: 20).padding()
                
                VStack(spacing: 0) {
                    HStack {
                        // Repayment Due
                        VStack(alignment:.trailing) {
                            FinDefaultText("N E T F L I X", .light, 14).foregroundColor(.getSecondaryColor)
                            FinDefaultText("SUBSCRIPTION", .light, 10).foregroundColor(.getSecondaryColor)
                        }
                        
                        VStack(spacing:0) {
                            Rectangle.init().frame(maxWidth: 1, maxHeight: .infinity, alignment: .center).foregroundColor(Color.getPrimaryDimmedColor.opacity(0.25))
                        }.frame(width: 10)
                        
                        // Detailed
                        VStack {
                            VStack(alignment: .leading) {
                                FinDefaultText("1.024.000 IDR", .bold, 14).foregroundColor(.getDarkBlue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                FinDefaultText("12 MONTHS", .regular, 10).foregroundColor(.getDarkBlue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        VStack {
                            FinDefaultText("1 Account Active", .regular, 12).foregroundColor(.getDarkBlue)
                        }
                    }
                }.padding()
            }
        }.animation(nil).background(Color.getLightWhiteColor)
    }
}

class dashboardViewBusiness: ObservableObject {
    
    // final
    final let wallet: Int = 100000
    @Published var currentWallet: Int = 0
    
    func classCalculateTotalWallet() {
    }
}
