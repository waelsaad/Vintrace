
Introduction:
------------
Thank you for the opportunity of doing this code challenge. I have enjoyed it, and I'd like to think I am presenting you with strong SwiftUI programming skills and design architecture. It's a masterpiece, in my humble opinion :]

Instructions:
------------
Xcode Version 15.3 (15E204a)

1- Ensure you have SwiftLint Installed on your machine - use brew install swiftlint
2- double click on Vintrace.xcworkspace and wait for SwiftUI Introspect Package to load
3- Simply Run the app, and you may also run the unit tests at a later stage. They should all pass :]

You may review the .swiftlint.yml to check all enforced rules to force best practice.

Proposed Solution:
------------------

I wanted to take this code challenge as an opportunity to present you with an alternative approach to how the Stock Item Scene
should be designed from a usability perspective. The buttons on the top, they are very clear that they are clickable to the user
and have a meaningful purpose.

Please kindly keep in mind that the following is my own personal humble opinion/approach, and I'm happy to be corrected. I could
have misunderstood the behavior :]

The Problem:
------------------

Contrary to the hero shots, yes, you can scroll through them, which is expected from a user perspective, but I was a little surprised
to see that in order to see the full view of the screen, you need to click on the hero shot to collapse and expand later upon clicking
on the navigation.

The user is not expected to know that clicking on the hero shot is to do that. It felt like it's an unnecessary step. The user is
expected to start scrolling the view naturally. Also, what happens when there is not enough content on the screen? What is the use
of clicking on the hero shot or top navigation in that scenario?

Proposed solution:
------------------

Hence I created an approach that I applied to my current project about a year ago where it's intuitive to the user to simply start
scrolling up, and they will start to see the full view while still applying the same effect of collapsing the header as in the demo
with smooth animation.

I used this library to assist with the smooth header animation
https://github.com/exyte/ScalingHeaderScrollView

I didn't just use it as it is; I actually had to modify it almost a year ago initially for my current project, and little did I know
that I would be using it at a later stage for a code challenge also. In the code, it's in a folder called ScalingHeader.

This is where you can see when I started learning about it
https://github.com/exyte/ScalingHeaderScrollView/issues/8

With this approach, all info is always available to be displayed to the user on the screen regardless of content size. A user simply
scrolls if required.

Notes:
------------------

I faced some discrepancies between what is in Figma and the demo, but I tried to get it as close as possible.

I created the buttons and icons programmatically. They should be identical to what's in Figma. This makes it so much easier and
faster to apply different icon designs anywhere in the code and have full control. Ideally, we should make use of available system
icons and integrate something like Google Material Icons or any other icon font assets.

Features:
------------------
        
1- SwiftUI, completely generic code with a wealth of reusable extensions for what is required to produce clean code.
Smooth animation.
2- Implemented using MVVM Design Pattern.
3- Eenhanced the user experience by seamlessly collapsing and expanding the header as the user scrolls through the content.
4- Easy to use Font implementation for the font Montserrat so you can do something like this:
    Text(text)
        .font(.montserrat.semibold(size: UI.FontSize.title))
5- In assets, I showed how to use colors with paths so you can do something like
    Text(text)
        .foregroundColor(.Text.Item.description).
6- Implemented programmatic creation of re-usable buttons and icons
7- Test-driven. Wrote unit tests to test important scenarios for the view models.


I hope you find these additional features helpful in evaluating the proposed solution. If you have any further questions or need clarification on any aspect, feel free to let me know!
