//
//  StoreItemTableViewDiffableDataSource.swift
//  iTunesSearch
//
//  Created by Tyler Sun on 1/26/23.
//

import Foundation
import UIKit
// making a subclass of uitableviewdiffabledatasource to make sections headers
@MainActor
class StoreItemTableViewDiffableDataSource: UITableViewDiffableDataSource<String, StoreItem> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section]
    }
}
