#Roomazon

Roomazon is an Android App made in Flutter Environment. 
It serves the purpose of finding Rental Rooms and Roommates.
It uses Dart Language on the front end and Firestore Firebase as back end.

------------------------- System requirements -------------------------

Microsoft® Windows® 7/8/10 (64-bit)
4 GB RAM minimum, 8 GB RAM recommended
2 GB of available disk space minimum,
4 GB Recommended (500 MB for IDE + 1.5 GB for Android SDK and emulator system image)
1280 x 800 minimum screen resolution

-------------------------- Software Requriments --------------------------

1.Android Studio 4.1.3 
	for Windows 64-bit (896 MiB) link to download this file ( https://developer.android.com/studio?gclid=Cj0KCQjwyZmEBhCpARIsALIzmnL1rQ-0wFD9FL96YUfKevDOiwUCepm4B14CUWwaRfawqEL3ToFVKnQaAqEeEALw_wcB&gclsrc=aw.ds)
	    Mac 64-bit  (877 MiB) link to download this file (https://developer.android.com/studio?gclid=CjwKCAjw7J6EBhBDEiwA5UUM2gppZ2LZJPayKMPy6I4atpDufQhKeBCeidMoek_FWB1Yaf0YY1jkCRoCZvgQAvD_BwE&gclsrc=aw.ds#downloads)

2. SDK tools package 

3. Flutter
	Installation Guide (https://flutter.dev/docs/get-started/install)
	
4.If running this application on android device then you need android verison above:- Oreo 8.0 API level 26

5.Internet connection in computer and mobile.

-------------------------- How to Run the Code in Flutter --------------------------

Method 1 (Easy):

	Step 1: Launch Android Studio.
	Step 2: Click on "Get from Version Control" and paste this URL : https://github.com/AshutoshVJTI/Roomazon.git , click 'Clone'.
	Step 3: Run 'flutter pub get' in terminal. (This step is necessary to get dependancies)
	Step 4: The code is ready to be run.

Method 2 (Lengthy):
	
	Step 1: Extract "Roomazon-final.zip" (Provided with Readme in Google Classroom) in 'AndroidStudioProjects' folder.
	Step 2: Launch Android Studio.
	Step 3: Click on "Open an Existing Project" and select Roomazon from 'AndroidStudioProjects' folder.
	Step 4: Run 'flutter pub get' in terminal. (This step is necessary to get dependancies)
	Step 5: The code is ready to be run.

* Note: I have also provided release apk in case anything doesn't work. (In Google Classroom)

If you are using Ryzen processor then you need to give permissions to the system follow  these:-
		
	 Alright, first of all, open your
	 Android SDK Manager: Tools -> Android -> SDK Manager, 
	 then chose any platform/package you want to download, expand it and select ARM EABI v7a System Image or ARM 64 v8a System Image then install.
		
	*NOTE: You don't need the beta version of Android Studio or Android Emulator.
		Go to the MB bios and turn SVM on (CPU Virtualization).
		In Windows right click Windows Button => Select "Apps and Features" => "Programs and features" => "Turn Windows Features on and off"
		In the displayed list select Hyper-V checkbox == Make sure the subfolders are all selected. When prompted to restart, restart the PC.
		After restart and update instalation screen you are back in Windows and you should be able to run the Emulator.

-------------------------------- Firebase Access --------------------------------

	Step 1: Login using following credentials (Email : Password: )
	Step 2: Now go to 'https://console.firebase.google.com/'
	Step 3: Select 'Roomazon'. (Accept Firebase Terms and Conditions if any)
	Step 4: In the left bar you can access 'Authentication' (for user login info), 'Firestore Database' (for data obtained from users about house and user details) and 'Storage' for all the images uploaded.

---------------------------- Privacy policy -------------------------------------

When you use our services, you’re trusting us with your Information. We understand this is a Big Responsibility and work hard to Protect your Information and put you in control.

This Privacy Policy is meant to help you understand what information we collect, why we collect it, and how you can update, manage, export, and delete your information.
	
