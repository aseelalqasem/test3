//
//  LocationsView.swift
//  NMap
//
//  Created by Assel ALQasem on 01/01/1444 AH.
//

import SwiftUI
import MapKit
//bobo 511
//Ahad test
// bushra
struct LocationsView: View {
    
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        //        List {
        //            ForEach(vm.locations){
        //                Text($0.name)
        //            }
        //        }
        ZStack{
            mapLayar
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                    .padding()
                Spacer()
                LocationsStackPrivew
            
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil){
            location in LocationDetailView(location: location)
        }
    }
}
struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var header: some View{
        VStack{
            Button(action: vm.toggleLocationList){
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }
            if vm.showLocationList{
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color:Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    private var mapLayar: some View{
       
                       
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: {location in
            MapAnnotation(coordinate: location.coordinates)
            {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture{
                        vm.showNextLocation(location: location)
                    }
            }
        })
        //                MapMarker(coordinate: location.coordinates,tint: .accentColor)}) هذا بو نبي دبوس عادي
        
    }
    private var LocationsStackPrivew: some View {
        
        ZStack{
            ForEach(vm.locations){ location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}


