# Charcha-app

Charcha is a chat application made using flutter and leveraging the power of Bloc architecture. This project aims to provide users with a seamless and responsive chatting experience while showcasing the advantages of using the Bloc pattern for state management.


## Key Features:

1. ### Flutter Framework:
  - Developed entirely with Flutter, a cross-platform UI toolkit, ensuring a consistent user experience on both Android and iOS devices.

2. ### Bloc Architecture:
  - Utilizes the Bloc (Business Logic Component) architecture to manage the application's state in a clean and modular way.
  - Separates concerns by dividing the application into three main components: Events, States, and Blocs.

3. ### User Authentication:
  - Implements a secure user authentication system using JWT, ensuring that only authorized users can access the chat application.
  - Both sign up and sign in features implemented in such a way that after entering email, user will be redirected to respective screen based on if they have already reistered or not.

4. ### 1-to-1 chats and real-time messaging:
  - Real time messaging system created using websockets. Users will be able send messages and also receive them without refreshing the current screen as sockets will keep listening to new message events.

5. ### Read receipts:
 - Read receipts are also created to show whether the receiver has opened the message or not. This feature is also implemented using Websockets and users can see the tick color changing from light grey to white when receiver opens the message.

6. ### Parent Messages:
 - Users can reply to any previous message by just double clicking on the message.

7. ### Dark Mode:
 - UI has been created for both light mode and dark mode lovers. Users will be able to select which mode they want for the app.

## Backend

Backend of charcha is made using node.js with typescript, expressjs and mongoDB. Link to the backend repository: https://github.com/Akshat1903/charcha-backend

## ScreenShots

### Onboarding Screens:

<p align="center">
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/ac69eabf-7481-4b70-9e7b-486cc9dacff8" width="200" />
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/9a59abfb-0205-4838-9cd0-3002aeb389ce" width="200" />
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/11c17395-1abc-4dfe-98aa-3db51f21d2d7" width="200" />
</p>

### Home + Seach + Chats Screens (Light mode):

<p align="center">
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/8703c967-0a4a-4a3c-9a99-06f6e2979f87" width="200" />
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/52aa75b3-4fec-4a00-b269-5644f8fad900" width="200" />
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/b12fe343-64d3-4a11-92e6-4cadb1f5659f" width="200" />
</p> 

### Home + Seach + Chats Screens (Dark mode):

<p align="center">
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/4aae05d8-18ee-4e90-9238-cfdf6a71a484" width="200" />
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/d46bea02-7194-448f-8ed5-2c7ef11b5276" width="200" />
  <img src="https://github.com/Shubh0405/Charcha-app/assets/59278577/eedcc478-e623-445f-95f9-e81c0bda0d6e" width="200" />
</p> 

## TODO:

1. Profile creation and edit screens.
2. Group chats.
3. Call feature.



**<p align="center">⭐️ If you find this project helpful, consider leaving a star to show your support! ⭐️</p>**
