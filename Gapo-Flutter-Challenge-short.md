## GAPO Challenge for iOS Developers

This is Gapo's Coding Exercise. It allows Gapo to assess candidates’ ability to develop a simple app with quality code.

You can start this any time you like. You can turn it in at any time. As you think about this exercise, please feel to ask questions!


Happy coding!

## Problem

Implement Notification List screen

## Design

https://www.figma.com/file/i4cmuJhojWnVpoF9uqY8Gi/Untitled?node-id=0%3A1

## Main features:

- Display all notifications got from API (mock from json file)
- Unread notification has different background color
- Tap a notification to turn it from `unread` to `read`
- User display name is bold, define by `notificaion.message.highlights` field
- Height of each cell row is dynamic, base on the text length

For search feature (Optional extra)

- Tap search icon to display search bar
- Search notifications by filter `notification.messsage.text` (search in local results that got from API get list notification)
- Tap `X` icon to return to list notification screen, hide search bar & search result

## Optional Extras

(These are ideas. You are not obligated to implement any of these. We prefer to see an app with limited feature set and quality code, as opposed to an app with more features that is hacked together)

- Allow to search a notification by filter `notification.message.text`

## Note
- Code must be runnable in both iOS + Android
- See the UI in figma file https://www.figma.com/file/i4cmuJhojWnVpoF9uqY8Gi/Untitled?node-id=0%3A1
- Using MVVM + RxDart is an advance, or use another Solid design pattern is an advance
- Having Unit test is an advance
- Having testing mechanism is an advance (Firebase, deploygate, diawi...)
- Having Readme & Installation guide is an advance
- Upload source code to github and send the completed repo
