//
//  BluetoothListViewController.swift
//  MotoricaStart
//
//  Created by Motorica LLC on 23.04.2025.
//
import UIKit
import DomainBluetooth

/// Assistant: Контроллер для отображения списка BLE-устройств
final class BluetoothListViewController: UIViewController {
    private let viewModel: BluetoothListViewModel
    private let tableView = UITableView()
    
    init(viewModel: BluetoothListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "BLE Devices"
    }
    
    required init?(coder: NSCoder) { fatalError() }

    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Обновляем таблицу при изменении devices
        viewModel.$devices
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onDisappear()
    }
    
    private var cancellables = Set<AnyCancellable>()
}

extension BluetoothListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.devices.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        let device = viewModel.devices[indexPath.row]
        cell.textLabel?.text = "\(device.name) (\(device.rssi) dBm)"
        return cell
    }
}
