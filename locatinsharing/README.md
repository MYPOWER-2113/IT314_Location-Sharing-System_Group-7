# Location_Sharing_System:

## Project Description:
Design a system to share the location of users between known people. Location can be of home, office, place where he/she usually goes. This system is useful for people who shift from one location to another. It can also be useful for carpooling, flat renting, hanging out, to know recommended service providers, etc. Different teams may consider different usage of this system.

## Tools and Technologies :

### Android studio:

Android Studio is the official Integrated Development Environment (IDE) for Android and App development. It is developed and maintained by Google. So there are many resources available for it. It includes a large community of developers so that one can get help whenever required. It also contains a wide range of plugins and supports different types of languages like Java, Kotlin, C++, etc. It also contains an emulator so one can run and debug their application.

### Mapbox :

Mapbox API is for custom maps. Mapbox is a platform for designing and delivering custom maps, geocoding and routing API’s and location-based services. It provides developers with a suite of tools for building applications that visualize, analyze, and interact with geographic data. It also supports various languages and frameworks. It provides SDKs for both android and iOS.

### Google maps API :

Google Maps API is a service provided by Google that allows developers to integrate maps and location-based features into their applications. The API includes a range of tools and services for creating and customizing interactive maps, geocoding, routing, and location-based services. It also supports various languages and provides SDKs for both android and iOS. It is widely used by developers and has quite good documentations.

### Flutter :

It is an open-source app development framework made by Google. It is easy to  build high-performance, visually attractive, and natively compiled applications using it. It supports all mobile, web, and desktop platforms from a single codebase. Flutter has a widget-based architecture, which allows developers to create complex user interfaces easily. It uses the Dart programming language to add logic in your application.

### Data Base : MongoDB

MongoDB is a NoSQL database that can handle large volumes of geospatial data. It offers geospatial indexing and querying capabilities, allowing for fast retrieval of location-based data. MongoDB can also be easily integrated with various mapping libraries and frameworks. It also includes built-in authentication service for secure access. It also supports storing data on the cloud.

## Implementation:

  1. When you’re creating an app, you might want to create a login function. We have use Flutter as the app, Node.js as a backend, and at least MongoDB for storing user info.
  2. Map API is loaded in the database. Mongodb is connected to Node.js server. And then it is loaded from MongoDB using Node.js when signed in.
  3. Now sign in and sign up page are implemented in flutter.
  4. When the app is launched, it will show a splash screen and then Signin page is displayed. Splash screen is to be merged with login page. A splash screen is a graphical control element consisting of a window containing an image, a logo, and the current version of the software.
  5. When signed in, it will display the basic map structure. So, Login page is merged with map homepage.
  6. Some functionalities are to be implemeneted in map home page. These are represented using buttons.
     - Navigation
     - SOS
     - ShareLiveLocation
     - Contacts
     - Friends
  7. Map homepage is merged with all these functionalities.
