//
//  BluetoothListViewModel.swift
//  MotoricaStart
//
//  Created by Motorica LLC on 23.04.2025.
//
import Combine
import DomainBluetooth
import DataBluetooth

final class BluetoothListViewModel {
    // Публикатор данных для таблицы
    @Published private(set) var devices: [BLEDevice] = []
    
    private let repository: BluetoothRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: BluetoothRepository = BluetoothRepositoryImpl()) {
        self.repository = repository
        // Подписываемся на поток найденных устройств
        repository.scannedDevicesPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.devices, on: self)
            .store(in: &cancellables)
    }
    
    func onAppear() {
        repository.startScanning()
    }
    
    func onDisappear() {
        repository.stopScanning()
    }
}
