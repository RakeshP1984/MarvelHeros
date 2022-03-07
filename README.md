# Marvel Characters
List Marvel Characters, search for a characters. View Character information, stories, comics, events and series characters appear in. 

## Application Architecture
The Application uses MVVM + Coordinator Architecture 
![Architecture Diagram](/AppArchitectureDiagram.png)
### Model Layer : 
Contains  Domain + Network API Layer
### Coordinator :
Are used to create all the dependencies i.e View Controller and ViewModels. They are also responsible for for navigating from one view controller to another or rather from on coordinator to another. The view communicates navigation related request to Coordinator the coordinator is responsible for routing to the next appropriate Coordinator.
### ViewModel :
The View model class are responsible for communicating with the model layer and providing data for the Views to be displayed
### View :
Represents the ui of the application.

## Project Structure
- Network : Home for all the model class and contains other networking classes that are responsible for communication with Marvel API service. Currently supports only one API service, characters. Use NSURLSession form communication. This layer is also responsible for extending service as defined in the Domain Layer
- Domain : The Domain layers list all the service used within the application. The ViewModel communicates with Domain Layer to fetch/update data.
- UIComponents : 
  - Containers are responsible for creation view controller, view model and navigation from one Container to another
  - Contains helper classes that help build UI. Components like SearchViewController, TableView, CollectionView and StackViewController can be composed together to create UI of the application. e.g SearchViewController and TableViewController can be composed with StackViewController to create Search with Table View controller. 
  - A few View classes do define structure for what they expect from ViewModel and Coordinators. 
- Dependency Manager : Simple implementation to help inject dependencies. 
- MarvelsHero App: Contains concrete ViewModel that are responsible for searching and listing of Marvel Characters. Also contains View Adapters that help adapt view model to view.  
