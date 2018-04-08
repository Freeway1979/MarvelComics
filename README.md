# Marvel Comic App 

@(Marvel)[iOS |Objective-C]

##What
- List of Marvel Super Heroes page by page
- Hero Detail View(Comics/Stories/Events/Series)
- Favourite/unfavourite a hero 

##Highlight
**All code are finished by Apple APIs whitout any third party framework or open source project.**
-	**MVVM**
	-	View (Basic presentation of view)
	-	ViewController(Focus on Views setup/delegate or Events/Work Flow)
	-	DataController(Focus on View Model composition,read/write,data cache)
	-	Model(Basic business model)
	-	ViewModel(Model for View)
	-	DataProvider(Network,Memory Cache,Local File)
-	**JSON2Model**
	-	JSONObject mapped to Customized Model(Conforms to a protocol),not inheritance.
-	**Network API Framework**(Wrapper of REST API)
	-	NetProvider (Wrapper over network api framework)
		-	MarvelNetProvider(Wrapper over netprovider,for business purpose)
-	**Image Cache**
	-	URL based Cache mechanism
		-	First memory cache
		-	Second Disk File
		-	Third Network resource 
			-	Once data feteched,saved to disk and memory cache.
	-	ImageView display binds URL easily
-	Customized Object Serialization
-	Customized View Controller Transition Animation
-	Customized UITableViewCell

