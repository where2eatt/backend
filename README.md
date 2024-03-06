# WHERE2EAT README

# Idea Overview

WHERE2Eat is an iOS app that will be used to help individuals, pairs, or groups schedule their meals by narrowing down dining options based on group preferences (such as dietary preferences) and availability. The goals of our project are to simplify the decision-making process for friend groups with keeping all dietary preferences in mind, to promote exploration of new restaurants and cuisines, to enhance group interaction and engagement, and to save time by providing all necessary information in one place.  


# Project Goals 
- Allow groups to find an ideal meal location for everyone
- Cater to dietary preferences so that everyone is able to enjoy the chosen place
- Motivate individuals to explore new cuisines and places they don't usually go to
- Find a restaurant that is at a location that is accessible and ideal for all in the group  

# Repository Layout
Frontend Folder
- File to connect iCloud for Google account login
- File to store user's profile and preferences
- File to generate food location options
- File to generate link and create new session
- File to create chatroom for group to communicate
- File to create calender availabilities
- File to check history of locations visited
- File to check the calendar for days of the current month

 Backend Folder
 - File for getting restaurant APIs
 - File for getting user APIs
 - File for messaging table
 - Filr for generating restaurants to source as options 


- # Repository Updates
  - Building/Running the System
      - Download XCode
      - Clone this file
      - Download iOS 17.2
      - Open up where2eat.xcodeproj in the simulator to run it
  - How to Test the System
    - Run the simulator
    - Make sure the interactions work as expected (text boxes, buttons, navigation bar) lead to the expected output
    - Use the Accessibility Inspector on XCode by going to Developer Tools and then Accessibility Inspector to test the accesibility
    - Adding new tests
       -To add a new test, make sure to create a YAML workflow file in the .github/workflows
       - Define triggers, jobs, and specify commands you want to have tested
       - Push these changes and examine to review and debug
   
  - # Technical Processes
    - Version Control
      - Using GitHub with regular commits and updates to the appropriate folders
    - Bug Tracking
      - Documented in our project live document
   -  Testing and CI
       - Using GitHub Actions that every push triggers
       - Makes sure that every change complies with what is expected in terms of any change not breaking the code
    
- # Working Use Cases
  - Can login and sign up to the app
  - Can view some template sessions
  - Can enter information to create a new session
