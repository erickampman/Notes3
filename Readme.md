# Notes3

This project is an exploration of a NavigationSplitView, loosely based on Apple's 'SwiftDataAnimals' demo project.

There are still a few warts, but it's pretty functional.

Things to note:
1. NavigationLink here is a strange beast. This uses a form of NavigationLink I think corresponds with "init<S, P>(S, value: P?)". At any rate, the info for this in the documentation is contained in section "Coordinate with a list".
2. The demo app uses a sheet to modify the data. I wanted to be able to edit the data in place, which turned out to be a bit tricky. Look at the .onChanged calls for info on this. 
3. I have been unsuccessful at both displaying the "Sort By" Picker and also getting it to function correctly in iOS. The problem is that 
a parent view needs to manage this picker, so it needs to be at the top level, but when I put it there it's not available in iOS. It works fine on macOS.
4. Previews are mostly disabled. Apple's demo project does quite a bit of work to get previews functional. Maybe I will take the time to do so.
5. The Save button in NoteView needs some feedback to tell the user Save worked. Maybe disabling when the content hasn't changed is the way to go.
