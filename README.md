# Location_Sharing_System:

## Project Description: 

A location-sharing system is an Android application allowing users to share their real-time locations with others. This Android application uses GPS technology to determine a user's location and share it with others through social media or a messaging system. This application allows users to create groups and share their location with their family and friends. This application can be accessed through a variety of devices such as smartphones, tablets, and laptops.

Benefits
- Increased safety and security : For example, parents may use this application to keep track of their children's whereabouts. Similar to this, relatives and friends can use location sharing to keep tabs on each other while travelling or participating in outdoor activities.
- Navigation purposes When traveling to unfamiliar places by sharing their location, individuals can easily guide others to their destination or receive assistance from others when needed. 
- Recommendations : This application suggests nearby places, such as restaurants, ATMs, hotels, hospitals, etc., to users. This application also has an emergency SOS feature that offers emergency service, allowing users to call for help quickly in case of an emergency. 

location-sharing system provide a path to stay connected and share their location with others. In summary, this android application allows individuals to share their real-time location with others. These systems offer a range of benefits, including increased safety and security, navigation assistance. However, users should be mindful of privacy and security concerns when using this application, and only share their location with trusted individuals.

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
  8. Navigation functionality is implemented which shows the best route to any destination(which is to be selected) from youyr current location.
  9. SOS Emergency functionality is implemented where clicking on a button sends notification to all your selected contacts and contacts list are displayed in another page.
  10. Sharing Live Location is implemented where there contains a dropdown menu where all the contacts in your phone are loades and is to be selected from which shares location with the selected contact.

## Getting Started

1. Install Android Studio and Flutter SDK, if you don't already have it.
2. Get the source code.
```
git clone https://github.com/MYPOWER-2113/IT314_Location-Sharing-System_Group-7.git
```
3. Open the sample into Android Studio.
4. Build and run the sample. You may need to update gradle and library versions. Follow the guidance provided by Android Studio.
5. Select the device in the Android Studio and Run main.dart file.
6. When you run the file, splash screen will popup containing the logo of the app. Then you will be directed to Sign In Page.
7. If you are using the app for first time, click on Sign Up, enter all the details then Sign In using the Email and Password.
8. You will be directed to Homepage and now you can search any location.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337697-5da30dd1-b61c-4f38-b4fe-245b734c1df6.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

9. There are other five buttons at bottom of the page for different functionalities.
10. Second button is for SOS Emergency functionality where you select the contacts of your close ones and click on the red button on emergency situation. That will send notification to all the selected contacts.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337665-f501f69d-676e-49a1-92c4-4db6e4bf0504.jpg">

<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337703-1c3b36c8-66b0-4fb6-8c4f-c2c6ed161033.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

13.  Third button is for Navigation where you can navigate to any destination from your current location.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337782-c7ad6d07-08f0-4919-89c0-be25d38208bc.jpg">

<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337792-ba0b3c83-1494-47ab-b473-3a84b1ef1755.jpg">

<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337798-352178bb-a4d7-4ead-ae92-cfca3463609a.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

14. Fourth button is for Sharing your current Location to any of your contacts.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337890-8a3c435c-73d9-4e66-a42a-e73f17f55134.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

15. In Fifth Button, contacts list are shown whic are selected to be notified at energency situation.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235337899-4e13dbaf-6a43-439d-af18-3ed8c5851073.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

15. In Search for neraby places.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235347426-94639047-bf4c-46be-a6e0-d99f9a9dee10.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

16. Click on the top left and know about Us, Frequently asked questions(FAQs) and you can logout anytime you want to.
<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235338078-646ef36b-3aec-451a-a3f0-dd291c4cb5e5.jpg">

<img align="left" width="200" height="400" src="https://user-images.githubusercontent.com/123552037/235347438-326a1b7e-af18-4ced-b12f-d4e7d73ea1dc.jpg">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
