# GameAppPetra

A mobile application for displaying video games made in Swift and Xocde.

## Description

AppGamePetra is a simple application consisting of 4 screens. When the application is launched for the first time, the Oboarding screen is displayed where the user can select the genres of video games that interest him. After that, the video games that belong to those genres are shown. By pressing the + in the upper right corner, the user is again presented with a list of genres where he can change his selection. By selecting one of the video games, a new screen opens showing some details about the selected game.

## Getting started

1. Use CocoaPods
2. StoryBoard is remove from project

## Dependencies 

CocoaPods is used as a dependency manager. List of dependencies:

pod 'SnapKit'
pod 'Alamofire'
pod 'AlamofireImage'


## Architecture

The idea was to work according to MVVM architecture, but for now it turned out more like MVC. :)


## Structure

The application consists of 4 screens that are implemented using UIViewController.
I structured the folders by screen names so that it will be easier to navigate trough project. 

The folders and files are as follows:

### Screens:
- GenreList 
Here is a Controller responsible for displaying the list of genres, also a button for saving genres in UserDefaults. It is used by the Onboarding screen and the Settings screen.

- Onboarding 
It only appears when the application is first launched. After that, the flag in User Defaults is changed and every second time the application is started, the GameList screen is displayed immediately. He uses the GenreList Controller where he makes minor changes to customize it for his needs.

- Settings 
It appears when the user presses the + on the top left of the screen. It uses the GenreList controller to display a list of genres and makes minor changes to customize it for his needs.

- GameList 
This screen displays all games from the selected genres using a TableView. Clicking on one of the cells with the name of the game opens a new screen with details.

- Details 
The screen is used to display details about the selected game. It uses a ScrollView to successfully display all the data.
    
### Additional auxiliary files:
- Network
Folder containing API models and clients.

- BaseView
There are protocols that determine the structure of the View in the project. If BaseView is inherited.

- TableViews
Auxiliary protocols for creating TableViews

- Supporting
It consists of imported fonts and AttributesBuilder files that extend existing classes to speed up and facilitate work.
    
#### Preference
This file contains functions that set or retrieve values ​​from userDefaults.

#### SceneDelegate
I made a change that reads the data from userDefaults and checks the isFirstLaunch flag to find out if the application is being launched for the first time. With regard to the flag, it goes to the Onboarding screen or the ListGames screen.

