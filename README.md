# GameAppPetra

A mobile application for displaying video games made in Swift and Xocde.

## Description

AppGamePetra is a simple application consisting of 4 screens. When the application is launched for the first time, the Oboarding screen is displayed where the user can select the genres of video games that interest him. After that, video games that belong to those genres are shown. By pressing the + in the upper right corner, the user is again presented with a list of genres where he can change his selection. By selecting one of the video games, a new screen opens showing some details about the selected game.

## Getting started

1. Use CocoaPods
2. StoryBoard is remove from project

## Dependencies 

CocoaPods is used as a dependency manager. List of dependencies:

- pod 'SnapKit'  
- pod 'Alamofire'  
- pod 'AlamofireImage'  


## Architecture

The idea was to work according to MVVM architecture, but for now it turned out more like MVC. :)


## Structure

The application consists of 4 screens that are implemented using UIViewController.
I structured the folders by screen names so that it will be easier to navigate trough project. 

The folders and files are as follows:

### Screens:
- GenreList - Here is a Controller responsible for displaying the list of genres, also a button for saving genres in UserDefaults. It is used by the Onboarding screen and the Settings screen.

- Onboarding - It only appears when the application is first launched. After that, the flag in User Defaults is changed and every second time the application is started, the GameList screen is displayed immediately. Oboarding Controller uses the GenreList Controller, making minor changes to customize it.

- Settings - It appears when the user presses the + on the top left of the screen. It uses the GenreList Controller to display a list of genres and makes minor changes to customize it.

- GameList - This screen displays all games from the selected genres using a TableView. Clicking on one of the cells with the name of the game opens a new screen with details.

- Details - The screen is used to display details about the selected game. It uses a ScrollView to successfully display all the data.
    
### Additional auxiliary files:
- Network - Folder containing API models and clients.

- BaseView - Contains are protocols that determine the structure of the View in the project. If BaseView is inherited.

- TableViews - Auxiliary protocols for creating TableViews

- Supporting - It consists of imported fonts and AttributesBuilder files that extend existing classes to speed up and facilitate work.
    
#### Preference
This file contains functions that set and get values ​​from userDefaults.

#### SceneDelegate
Function "scene( scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)" is changed so that it reads the data from userDefaults and checks the isFirstLaunch flag to find out if the application is being launched for the first time. With regard to the flag, it goes to the Onboarding screen or the ListGames screen. I left the variable Preference.isFirstLaunch = false commented if you want to try again later and see the onboarding screen

## Decisions, problems...

- Images in TableView :  
 
Biggest problem was loading genre background images to TableView. The reading and loading from API was slow and it broke the table. That is the reason I decided to load all images in advance (when the screen appears) and save them in the model (GenreCellModel) instead of just savig the url. This helped because now the table looks normal and doesn't get confused. 

- UserDefaults and models :  
  
I spent some time thinking about how to save selected genres in UserDefaults. In the first version, I saved only the id of the genre, but that turned out to be complicated because in the settings screen I would have to read all the genres from the API again and compare the Ids and only then enter them into the model (GenreModel). That's why I decided to save the entire model in UserDefaults (but it's important to note that I only saved the url of the image, not the entire UIImage, and I loaded the image only when I went to enter data into the model (GenreCellModel)).

- GenreList, Onboarding and Settings:  

I didn't want to repeat the code, so I thought about the best way to use the same GenreList controller in the Onboarding and settings screens. I added the GenreList controller to each of them as a child. The GenreList controller has colsures that I defined from the other two controllers to get the desired functionality. I wanted Onboarding to read data from the API and save it in the model, and Settings to read from UserDefaults.

- Design :   
  
The design is simple and does not use any additional libraries. I used the colors that I think are most suitable for the given theme - video games.
