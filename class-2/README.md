#Week 8 - Class 2
##Lab Assignment
* Seed your data base with the JSON payload provided
* Implement Book functionality. Guests should be able to set both, the start and end reservation dates, specify the room they want and finally book it.
	* Guest name is required... feel free to add more requirements.
	* When selecting dates, users should not be allowed to select dates in the past for the start date.
	* Users should also not be able to book an end date before a start date.
		* Present an alert for the user if they attempt the above.
* Add Attributes to your ManagedObjectModel.
* Change your Guest model accordingly to have firstName, lastName, and email address.
* Update UI to include fields for lastName and email in BookVC and setup constraints.
* Assign lastName and email to guest.

###Reading Assignment:
* Apple Documentation + Other
  * [Unit Testing Overview](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UnitTesting.html)
  * [Introduction to NSFetchedResults Controller](http://nshipster.com/unit-testing/)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000fQdt4rvdN6s1yl9IyBrxRg#Week8_Day2)

1. Create NSObject Category for Context.
2. Add creation methods to reservation + guest
3. Implement BookViewController
4. Implement AvailabilityVC

UIDatePicker & UIPickerView
Date Handling
Advanced Fetching

Implemenbts an object that uses rotiating wheels to pick dates or time.

Can be used as a countdown timer.

Has a date property that simply returns the current selected date in the date picker.

Supports IBActions that fire any time the date has changed

Has an intrinsic width of 320, you can squeeze it down to 230 and still see everything.

Has options in the storyboard attribute.

UIPickerview is similar to DatePicker but allows you to fully customize what picker displays instead of just dates and times.

Follows data source pattern:
numberOfComponentsInPickerView:
pickerView:numberOfRowsInComponent:
pickerView:titleForRow:ForComponent:

NSDate - representation of a single point in time

NSCalendar - representation of particular types

just init a NSDate instance
Use calsas method date() on NSDate
Use one of NSDate's initWithTimeInterval init methods for sepcific dates creation

Use an NSCalendar and date COmponents

NSDateComponent class!

use methods like setDay: setmonth: setYear: et to set individual components.

use dateByAddingComponents:toDate:options: on calnedar to add components.

Advanced Fetching NSHipster!

Creating Fetch Requests

Use plain initializer

Use an initializer that takes in a entity name that you want to fetch against.

Accessing a fetch request that we pre-made in the MOM file
Same as 3, but there is a method you can use to pass in extra variables for the fetch to be used in the predicate

Query language describing how data should be fetched and filtered.

Describes logic conditions to use when searching collections.

Used in Core Dat, but can also be used to filter regular foundation classes like arrays and sets.
Familiar with SQL?  Think of WHERE.

When creating a predicate, use a prediate string to communicate to the database what exactly you're looking for.

Predicate string parser is whitespace insensitive, case insensitive, and assupportes nested parenethetical expressions

The parser does not do any sematnic type checking, so typos will cause run time error
Use predicateWithFormat for building simple predicates

You can use %@ to substite for an object (usually a string)
you can use %K to subetstite for an attribute or attreibutes (via key path)
