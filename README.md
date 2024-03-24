# Flutter front for CHATGPT APP.

User can login to service with e-mail address. After e-mail verification user can ask CHATGPT questions with the app.
User has the ability to clear the query history and start a new conversation. When user deletes chat history, it is destroyed from this apps database.

Start screen:
![Simulator Screenshot - iPhone 15 Plus - 2024-03-19 at 21 39 44](https://github.com/Geezter/fluttersakky/assets/96491295/6bb58a3b-e5c2-4c0c-9187-05f22e18babd)

Start screen is used to connect to backend and send the token from devices memory.
If there is token and it is valid, backend check's if the users email provided with the token is verified.
If user e-mail is found from the database, backend check's out if the e-mail is verified.

If user doesn't have token to send to the backend, app is directed to login page:
![Simulator Screenshot - iPhone 15 Plus - 2024-03-19 at 21 40 55](https://github.com/Geezter/fluttersakky/assets/96491295/21af021e-8ace-4aec-b4c7-03ec4cec3f84)

Here user gives their e-mail address. After this user is directed to verify page. When user gives e-mail, they are directed to verify page every time.
Verification cpde will be sent to users given email.
![Simulator Screenshot - iPhone 15 Plus - 2024-03-19 at 21 41 14](https://github.com/Geezter/fluttersakky/assets/96491295/13190739-968f-4ab9-991e-dee725c90ea6)

After verification, app tells they are verified:
![Simulator Screenshot - iPhone 15 Plus - 2024-03-19 at 21 42 26](https://github.com/Geezter/fluttersakky/assets/96491295/aa5db8d8-8808-4816-a364-5760390fdba7)

After this, user is directed to chatBox:
![Simulator Screenshot - iPhone 15 Plus - 2024-03-19 at 21 39 47](https://github.com/Geezter/fluttersakky/assets/96491295/c3764bf0-c4b8-4e53-ac4e-3cb9da06b63d)

If user has un-deleted messages, they are listed here.


Few things about the start screen:

If user has logged in before with the same device and it has the users token saved, they will be directed straight to chatBox.
If user has not verified, they will be directed to verify part.

Jarkko Rissanen 2024
