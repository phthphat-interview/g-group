# Project for interviewing in GBoard

## Architecture
- MVVM without RxSwift (because I'm too lazy to integrate it).
- You will see the UI coding style somehow look like SwiftUI. Yes, I'm a Declarative UI lover.
## Some used packages
- Using 3 extra-light coding style pacakges: [DeclarativeStyle](https://github.com/phthphat-lib/declarative-style), [UIStackViewHelper](https://github.com/phthphat-lib/uistackview-helper), [AutoLayoutHelper](https://github.com/phthphat-lib/autolayout-helper) (which is core UI coding style in Go2Joy, of course, all were made by me)
- Using [Kingfisher](https://github.com/onevcat/Kingfisher) to load image from internet

## How to run
- Just clone and open `xcproj` file, there're nothing else to do (maybe u will need to wait until all packages to be downloaded)

## Minium iOS required
- iOS 12 or later (the fact that you can also use even for iOS 11)
- I'm run it in iOS 15 so there maybe some bugs in lower ios version