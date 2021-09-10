# Pre-work - Simple Tip Calculator (STC)

STC is a tip calculator application for iOS.

Submitted by: Aramis Tanelus

Time spent: 6 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly

The following **optional** features are implemented:

* [ ] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Add constraints to storyboard elements to improve user experience across devices
- [x] Substitute custom colored keyboard for standard keyboard
- [x] Perform checks on numeric input to prevent user errors like entering two decimal points.

## Video Walkthrough

Here's a brief walkthrough of its features:


![](https://i.imgur.com/pI6Rw3j.gif)



## Notes

Describe any challenges encountered while building the app.

- Had some issues with the simulator preferring the hardware keyboard over a simulated keyboard
- Ran into several issues related to making data available to multiple instances of viewcontroller, especially when it has to be modified by one of the controllers

## License

    Copyright 2021 Aramis Tanelus

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
