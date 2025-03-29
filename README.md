# Project 4 - *MemoryGame*

Submitted by: **Samuel Lopez**

Memory Game is an app that tests your memory by letting you flip over cards to find matching pairs. 
You can reveal two cards at a time, and if they don't match, they flip back. Continue matching pairs until all cards are removed!

Time spent: **2** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App loads to display a grid of cards initially placed face-down:
  - Upon launching the app, a grid of cards should be visible.
  - Cards are facedown to indicate the start of the game.
- [x] Users can tap cards to toggle their display between the back and the face: 
  - Tapping on a facedown card should flip it to reveal the front.
  - Tapping a second card that is not identical should flip both back down
- [x] When two matching cards are found, they both disappear from view:
  - Implement logic to check if two tapped cards match.
  - If they match, both cards should either disappear.
  - If they don't match, they should return to the facedown position.
- [x] User can reset the game and start a new game via a button:
  - Include a button that allows users to reset the game.
  - This button should shuffle the cards and reset any game-related state.
 
The following **optional** features are implemented:

- [x] User can select number of pairs to play with (at least 2 unique values like 2 and 4).
  * (Hint: user Picker)
- [x] App allows for user to scroll to see pairs out of view.
  * (Hint: Use a Scrollview)
- [x] Add any flavor you’d like to your UI with colored buttons or backgrounds, unique cards, etc. 
  * Enhance the visual appeal of the app with colored buttons, backgrounds, or unique card designs.
  * Consider using animations or transitions to make the user experience more engaging.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

https://youtube.com/shorts/7elvUukQ5fA

## Notes

One challenge was handling the timing between flipping two cards and flipping them back if they didn’t match. Another challenge was 
making the grid scroll properly with larger numbers of pairs. Overall, it was fun experimenting with SwiftUI animations to create a more polished experience!
