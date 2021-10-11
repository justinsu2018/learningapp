//
//  MapView.swift
//  LearnApp
//
//  Created by Justin Su on 11/10/21.
//

import SwiftUI
import MapKit

struct MyMapView: UIViewRepresentable {
    
    func makeUIView(context: Self.Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        return mapView
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Self.Context) {
        
    }
}

struct MyMapView_Previews: PreviewProvider {
    static var previews: some View {
        MyMapView()
    }
}
