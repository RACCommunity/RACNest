#### 3. Search 🔍

For a begginner in the FRP paradigm, throttling is a foreign concept. A quick way  to understand it in the real world is via a search. Let's imagine that you are searching something and everytime you tap the keyboard a new server is initiated. This can be quite expensive and complex to implement. So:

1. Character "A" is inputted. 
2. New server call starts.
3. Character "B" is inputted.
4. Cancel the current on going server call and initiate a new one

The problem with this approach is that it doesn't take into account the frequency at which a new letter is inputted. Not only that, it's a waste of resources.

Throtlling solves this problem by creating an interval between each input. Imagine that the user is inputting a new letter every 0.1s. If we set throttling with an interval of 0.5s, only at the 5th letter the search will commence. This makes more sense than going back and forth with new requests and cancelling the previous one. 
