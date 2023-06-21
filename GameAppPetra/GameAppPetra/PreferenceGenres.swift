import Foundation

enum Preference {
    private static let selectedGenresKey = "SelectedGenresKey"
    private static let isFirstLaunchKey = "IsFirstLaunchKey"

    static var selectedGenres: [GenreModel] {
        get {
            guard let data = UserDefaults.standard.data(forKey: selectedGenresKey),
                  let genres = try? PropertyListDecoder().decode([GenreModel].self, from: data)
            else {
                return [GenreModel(genreId: 0, name: "", backroundImage: "")]
            }
            return genres
        }
        
        set {
            if let encodedData = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: selectedGenresKey)
            }
        }
    }
    
    static var isFirstLaunch: Bool {
        get { UserDefaults.standard.bool(forKey: Preference.isFirstLaunchKey)}
        set { UserDefaults.standard.set(newValue, forKey: Preference.isFirstLaunchKey)}

    }
}


