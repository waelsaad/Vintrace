# vintrace Coding Challenge

We invite you to demonstrate your iOS/Swift expertise by implementing an app mock-up based on our original design.

Your submission must:
- Be written in Swift and use SwiftUI instead of UIKit if possible
- Be entirely your own work
- Adapt correctly to different iPhone device sizes
- Be provided as an Xcode project in a zip file containing all necessary files for compiling and running

Feel free to use 3rd party libraries if necessary, but include instructions on how to integrate them into the project.


## Context

The Stock Item Page is an essential part of the vintrace inventory management application. Its primary purpose is to provide users with a comprehensive overview of a particular stock item, including its images, descriptions, quantities, and components. 

The detailed information presented on this page allows users to make informed decisions about stock levels, item components, and overall inventory management. The smooth UI transitions and animations, along with the responsive layout, ensure a seamless user experience across various iPhone device sizes.

The Stock Item Page is designed to be functional, visually appealing, and user-friendly, ultimately helping users manage their inventory effectively and efficiently.

## Instructions

### Mock-up

Develop a user interface and controller for the mock-up available at the following URL:

https://www.figma.com/file/0U7lYucs6mn7ZhcG28M6ry/vintrace-mobile-challenge?t=S6nUyRg2e9bYB2JO-1

You will need to log in or sign up to Figma to access assets, font sizes, spacings, colours, etc.

Strive to make your implementation as faithful to the design as possible.

If you are unable to implement certain design elements, provide a close alternative and explain why the original could not be implemented in your submission.

The Figma file contains two pages:

- **Inventory Page:**
  This page displays the inventory stock item in two states: expanded and collapsed. The header section should transition smoothly from the expanded to the collapsed state as the user scrolls up.

- **Assets:**
  This page contains all the assets required for this challenge. Export them using `Ctrl+Shift+E` (or `Cmd+Shift+E` on macOS).

### JSON data

We have provided JSON files containing the data displayed in the mock-up. During testing, we will also use JSON files with the same structure but different data to ensure your implementation can handle variations in table cells and dynamic values.

The data describes an inventory item's basic details (referred to as a stock item), including item type, quantities, unit of measurement, components, and more. From this point on, when referring to a specific field in the JSON data, we will use dot notation from the stock item. For example, `stockItem.unit.abbreviation` refers to the abbreviation of the stock item's unit of measurement.

### UI and Data Relationship

The mock-up represents the JSON data in the `stock-item-1.json` file.

#### Header Section:

The header section displays (From top to bottom in order):

- `stockItem.images`: Contains 0 or more image endpoints (for this challenge: `/images/wine-1`, `/images/wine-2`, `/images/wine-3`, or `/images/wine-4`, available in the Figma assets). This section should be horizontally scrollable. If the `stockItem.images` array is empty then the `stock-item-generic-1.jpg` image file should be displayed.
- `stockItem.code`: "CHRD/EU/2016"
- `stockItem.description`: "Standard EU export bottle"
- `stockItem.secondaryDescription`: "Bottle - 750 ml" (optional, should be hidden if not provided)
- A filled circle representing `stockItem.beverageProperties.colour` followed by `stockItem.beverageProperties.description` (optional, should be hidden if `stockItem.beverageProperties` is `null`).
- `stockItem.owner.name`: "vintrace Winery"
- `stockItem.unit.name`: "Single bottle (x1)"

#### Levels / Quantities:

- **On Hand:** Physically available amount in the warehouse (`stockItem.quantities.onHand`).
- **Committed:** Amount committed for future operations (`stockItem.quantities.committed`).
- **In production/ordered:** Amount to be received in the future (`stockItem.quantities.ordered`).
- **Available:** Calculated as `onHand + ordered - committed = available` (not in JSON data). 

The colour for this value should be green if positive, black if 0 and red if negative.

\* The "Edit" button next to "Levels" should display a default iOS alert.

#### Components

A stock item may consist of a combination of other stock items, called components. If present, components are found in the `stockItem.components` array.

Display the number of components (`stockItem.components`) in the section header next to the "Components" label.

If the components array is empty, hide the components section in the list. Otherwise, display each component in the list.

Each component contains the code (stockItem.components[n].code), description (stockItem.components[n].description), quantity (stockItem.components[n].quantity), and unit (`item.components[n].unit.abbreviation`). The unit should be displayed only if `stockItem.components[n].unitRequired` is `true`.

Each item in the components array represents a summary of the stock item for that component. Tapping on a component in the UI should navigate to a new stock item page.

To obtain the full data for a component's stock item, use the endpoint property in the component (`stockItem.components[n].endpoint`), which follows the format `/stock-items/{id}`. The JSON data for these endpoints is included in the archive (`stock-item-2.json`, `stock-item-3.json`, ...).

### Desired UI Behavior

We would like to see a smooth animation of the header shrinking, with most information in the header disappearing as the list is scrolled up. A video file in the archive demonstrates the expected scrolling behavior. You can also use the "play" button in the top right corner of the Figma page to enter presentation mode and interact with the prototype.

When the header is at its smallest, only the stock item's code should be visible.

Additionally, the "..." button in the navigation bar should open an in-app browser displaying the vintrace website ("www.vintrace.com").

The "Edit" button in the nav bar can simply display an iOS alert.

### Assets and Fonts

Export all icons and images from the "Assets" page of the Figma file.

The font used is "Montserrat".

### Contact Details

Please contact us via email if you need any additional details.

### Note

In addition to the user interface, our staff will review your source code. Ensure that your submission is readable, maintainable, testable, and meets the quality level we would expect if you were employed by us.

Please also note that if you had to skip any part of the implementation due to time constraints, include an explanation in a separate `.md` file detailing how you would have approached and solved the omitted portion if given more time. This will help us understand your thought process and problem-solving abilities, even if you couldn't fully complete the challenge within the allotted time.


