// EmojiDictionary

import UIKit

private let reuseIdentifier = "Item"
private let columnReuseIdentifier = "ColumnItem"

private let headerIdentifier = "Header"
private let headerKind = "header"

class EmojiCollectionViewController: UICollectionViewController {
    @IBOutlet var layoutButton: UIBarButtonItem!
    
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        ]
    var sections: [Section] = []
    
    enum Layout {
        case grid
        case column
    }
    
    // property by default is set to grid
    var activeLayout: Layout = .grid {
    
        didSet {
            // locate new requested layout
            if let layout = layout[activeLayout] {
                // if found reload the visible items in the collection view
                self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
                
                // updates the collections view layout to the new layout and animates changes
                collectionView.setCollectionViewLayout(layout, animated: true) { (_) in
                    switch self.activeLayout {
                    case .grid:
                        self.layoutButton.image = UIImage(systemName: "rectangle.grid.1x2")
                    case .column:
                        self.layoutButton.image = UIImage(systemName:  "square.grid.2x2")
                    }
                    
                }
            }
        }
    }
    
    var layout: [Layout: UICollectionViewLayout] = [:]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout[.column] = generateColumnLayout()
        layout[.grid] = generateGridLayout()
        
        if let layout = layout[activeLayout] {
            collectionView.collectionViewLayout = layout
        }
        
        // register the header as a supplementary view
        collectionView.register(EmojiCollectionViewHeader.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: headerIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSections()
        collectionView.reloadData()
    }
    
    // MARK: generating methods
    func generateColumnLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(120)), subitem: item, count: 1)

        group.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: 0, trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = padding
    
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)
        
        section.boundarySupplementaryItems = [generateHeader()]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func generateGridLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 20
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)), subitem: item, count: 2)
        
        // interitemspacing sets the interior spacing between cells contained by a group
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = padding
        
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)
        
        section.boundarySupplementaryItems = [generateHeader()]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func generateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // sets headers height to 40
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)
        ),
           elementKind: headerKind,
        alignment: .top
        )
        // makes a sticky header
        header.pinToVisibleBounds = true
        return header
    }
    
    func updateSections() {
        // sections array is removed
        sections.removeAll()
        
        // new dictionary is created with keys that are equal to the calculated section by alphabet
        let grouped = Dictionary(grouping: emojis, by: { $0.sectionTitle })
      
        for (title, emojis) in grouped.sorted(by: { $0.0 < $1.0}) {
            sections.append(
                Section(
                    title: title, emojis: emojis.sorted(by: {$0.name < $1.name })
                )
            )
        }
    }
    
    @IBAction func switchLayouts(sender: UIBarButtonItem) {
        switch activeLayout {
        case .grid:
            activeLayout = .column
        case .column:
            activeLayout = .grid
        
        }
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].emojis.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = activeLayout == .grid ? reuseIdentifier : columnReuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! EmojiCollectionViewCell
    
        //Step 2: Fetch model object to display
        let emoji = emojis[indexPath.item]

        //Step 3: Configure cell
        cell.update(with: emoji)

        //Step 4: Return cell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! EmojiCollectionViewHeader
        
        header.titleLabel.text = sections[indexPath.section].title
        
        return header
    }

    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            // Editing Emoji
            let emojiToEdit = sections[indexPath.section].emojis[indexPath.item]
            return AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        } else {
            // Adding Emoji
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        }
    }
  
    func indexPath(for emoji: Emoji) -> IndexPath? {
        // finds the approriate section for the emoji using the sectiontitle variable
        if let sectionIndex = sections.firstIndex(where: { $0.title == emoji.sectionTitle}),
           // finds the emojis index in the emojis arr of the calculated section
            let index = sections[sectionIndex].emojis.firstIndex(where: { $0 == emoji })
        {
            // if they found return a newindex path using the values above
            return IndexPath(item: index, section: sectionIndex)
        }
        // if it can't be found return nil
            return nil
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? AddEditEmojiTableViewController,
            let emoji = sourceViewController.emoji else { return }
        // checks the selected collection view items to see if it was selected
        if let path = collectionView.indexPathsForSelectedItems?.first,
           // checsk the source of the emoji list for the emoji that was just modified and grabs the first index
           let i = emojis.firstIndex(where: { $0 == emoji })
        {
            // if lets above have values it will the emoji data source is replaced with the updated emoji
            emojis[i] = emoji
            // sections are updated
            updateSections()
            // collection view reloads items that were just modified
            collectionView.reloadItems(at: [path])
        } else {
            // if both are nil the new emoji is add to the emoji arr
            emojis.append(emoji)
            
            // sections are updated
            updateSections()
            
            // new item is add to the collection view
            if let newIndexPath = indexPath(for: emoji) {
                collectionView.insertItems(at: [newIndexPath])
            }
        }
        
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { (action) in
                self.deleteEmoji(at: indexPath)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        
        return config
    }

    func deleteEmoji(at indexPath: IndexPath) {
        let emoji = sections[indexPath.section].emojis[indexPath.item]
        // finds the emoji to be deleted using the indexpath
        guard let index = emojis.firstIndex(where:  { $0 == emoji }) else { return }
        
        // emoji is removed from arr and section
        emojis.remove(at: index)
        sections[indexPath.section].emojis.remove(at: indexPath.item)
        
        // deletes emoji from the collection view
        collectionView.deleteItems(at: [indexPath])
    }
}
