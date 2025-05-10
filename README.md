# gif_search_app

## Notes
- Unable to compile for iOS due to not having access to a Mac

# Flutter developer

## Platform guidelines:
- Using MP4 and WEBP renditions where supported. This will maximize quality and reduce load times.
- Use the smaller fixed_height or fixed_width renditions on your preview grid.
- Use the largest possible rendition for the share or send. Once the user has selected a GIF, give them the best quality possible!

## The Task:
- Create a gif search application using the Giphy service;

### Primary Requirements:
## Technical
- [x]Primary platforms - iOS & Android;
- [x]Auto search - requests to retrieve Gif information from the service are made automatically with a small delay after user stops typing;
- [x]Pagination - loading more results when scrolling;
- [x]Vertical & horizontal orientation support;
- [x]Error handling;
- [x]Unit tests - as much as you see fit;
  
## UI
- [x]Responsive & matching platform guidelines;
- [x]At least 2 views sourced by data from Giphy;
- [x]Results are displayed in a grid;
- [x]Clicking on a grid item should navigate to a detailed Gif view.
- [x]Loading indicators;
- [x]Error display;

### Bonus points:
- [ ]Using state management approaches or libraries such as BLoC (flutter_bloc), Riverpod or others;
- [x]Using an understandable architecture pattern;
- [ ]Page navigation is separate from page widget code (a Coordinator pattern or similar);
- [ ]Network availability handling;

### Notes:
- No time limit. Quality > Speed;
- Documentation (https://developers.giphy.com/docs/api/)
- UI up to interpretation - only things mentioned in requirements are mandatory;
- Flutter version MUST be noted in repository ReadMe file;
- If you were not able to complete some of the requirements, please note down what you tried and what was the result;

