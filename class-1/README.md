#Week 8 - Class 1
##Lab Assignment:
* Setup your MOM with entities for Hotel >> Room >> Reservation > Guest
* Seed your database with a few hotels and rooms.
* Create a table view based hotel list view controller. This should show a list of hotels
* Upon selecting a hotel, push to RoomsViewController, which shows all the rooms of that hotel in another table view.

###Reading Assignment
* Programming In Objective-C
  * **Chapter 12:** The Preprocessor
* Apple Documentation
  * [NSDateFormatter](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDateFormatter_Class/)
  * [NSPredicated - NSHipters](http://nshipster.com/nspredicate/)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/0005t6TSbbUEfw8Mme0uKA_mQ#Week8_Day1)

#Week 8 - Class 1
##Lab Assignment:
* Setup your MOM with entities for Hotel >> Room >> Reservation > Guest
* Seed your database with a few hotels and rooms.
* Create a table view based hotel list view controller. This should show a list of hotels
* Upon selecting a hotel, push to RoomsViewController, which shows all the rooms of that hotel in another table view.

###Reading Assignment
* Programming In Objective-C
  * **Chapter 12:** The Preprocessor
* Apple Documentation
  * [NSDateFormatter](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDateFormatter_Class/)
  * [NSPredicated - NSHipters](http://nshipster.com/nspredicate/)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/0005t6TSbbUEfw8Mme0uKA_mQ#Week8_Day1)

In a tree data structure, and its diffeernt types, the root node is the topmsot node.

IN a binary tree, each node contains a left and right reference and a data element

Every node is connected by a directed ege from exactly one other node.  That node is considered the parent.

The left and right references a node can have are considered node's children.

Nodes without any children are considered leaves (or sometimes exteranl nodes)
Nodes with the same parent are siblings.

Depth of the node is the number of edges or connections from the root of the node.

the heigth of the node i sthe number of connections from the node to its deepest leaf.

The height of a tree is the height of its root node.

Binary search tree is a binary tree where each ndoe has a comparable key that satisfies the restrictino that the key in any node is larger than all keys in all nodes in that node's left and right.

RECURSION - kinda like linked lists.

Programmatic Layout!
Sometiems laying out part of all your interface is more onvenient to do in code rather than in storybaord or nib.

This will add a lto mroe code to the app, but give more control.

Setup for programatic layout:
Delete Main.storyboard.
Delete storyboard reference in rpoject settings.

override loadView: method in your main ViewController. Give your view a background color.

Instantiate UIWindow

Set rootViewcontroller on window


When yo uare creating views programmatically, proper place to do it is by iverriding your VC loadVIew.

Create additional subviews and att ehm to the root view.

Add auto layout  constraints necessary to view hierarchy.

Constraints are from class NSLayoutConstraint.

Constraints can be reated wtih VFL (Visual formatting lganguage) you use method
constraintWithVisualFormat:options:metrics:views:

Create the views that are going to makeup our interface and add them to the root view.

Set translatesAutosizingMaskIntoConstraints to false.

Create a dictionary that will contain key value pairings for all the views youare going to be applying constraints to.

When writing your visual format strings, you begin wiht iether H (horizontal) or V (veritcal).

Every view in your visula format string is respresented in squar ebrackets
Names of views come from dictionary we setup.  The dictionary is passed in as a parameter.

Conections betwene views is represente dby using a hyphen, or two hyphens with a number in between to represent he umber of points the views should be.

The super view is prepresented by ||pipes

You can use parents () to set vaules for fixed W and H.

Originally, all databases were flat. Information was stored in one long text file. Each entry was separeted by a | pipe

Works but makes searching database slow.

Relationshal databases make finding specific information faster and easier.
Relationsal databses store information in tables - like excel

each column represents a field - like attribute property

Each row is a record.

Persists object to disk, reads objects from disk.

the PSC assocaites persistent store objects and a managed object mdoel and presents a facade to managed object contexxts

Lumps all store objects together, so the dev it appears as a single store.  Most apps only need one but a super compelex app has several.

Sits between managedObjectContext & persisetn store (file on disk)

Has a reference to the managedObjectModel (MOOM)
Can automatically migrate oyur existing database to new schema.

Managed object model is a set of objects that ogether form abluebprint desciribg the manage dobjects you use in the app.

MOM allows core data to mapr eccorsd from persisetn store to managed objects that you use in your app

Describes a Core Data database schema: entiries 9objects), attribuates (iobject properties), lrelationships, validation (e.g. regex for email address), storeage rules (separate file fr binary data)

It is a collection of entity description objects.

Entiries can use ineheritance like regular classe.

COmponents of an etntiy are called attribuets and references to other entity objects are called relationships.

Attributes represent hte containment of data.

An atribute can be a simple vaue like a scalar (int, float, double)

C struuct (array of cahars, NSPoint)

instanc eof primitive class 9NSNumber or NSData)
Core data is specific baout what types of data ist supprots, but there are techniceus for storing non standard as well.

For ints, 3 types; int16, int32:, int64
Double and float
Binary data for saving instances of NSData
Transofmrable for saving instances of classes that can be converted to and from NSData.  Antyhing NSCoding compliant.

Not all properties of an entity are attributes, some are relationships to other entiries

These relationships are inherently bidirectional, but youcan set them to be navigable in only one direction with no inverse.
The cardinality of relationship tells you how many objects can potentially resolve the relationship.  If the destination object is a single entity, it is considered a one-to-one relationship.
If there are more than obe object, it's a one-tomany relationship.
Relatiponships can be optional or mandatory.
The values of a to-one relatinship is just the related object, the value of the to-many in CoreData is an NSSet olelction of all related objects.

Managed OBject

An instance of an entiryr represents a record from persisetnt store.
Takes the place of your regular model objects.
Instance of NSMangerdObject or a subclass of it
Every managed object is registered with a context
In a given context, there is at most one instance of a managed object that correspondes to a given record.

Custom manged objet classes

NSManagedObject provides a rich set of default behaviors
THis is the preferred way to crete and interact with isntances of entiries
The main advantage you get with your custom subc alsses are you don't have to call setValue:forKey anymore
Instead you get access to the attributes in the MOM file as propertyes on the objects.

Core Data "owns" the life-cycle of managed objects.  Objects can be created, destroyed, and resurrebtcted by framework any time.  Ther eare different methods you can override to customize intiailiztion of your managedOBejcts

awakeFromInsert: invoked only once in the lifetime of an object

The link between your code and database.
Represents a single object space in Core Data app
Manages a collection of managed objects

These objects represent an internallyc onsistent view of the persisten tstores
Context is the central object in the Core Data stack
It is connected o the persistent store coordinator
very managed object knows which context it belogns to, and every context knows which object its managing.

Get a reference to your context
Insert a new entity into the context
Set attributes
Call save() on the context, passing in an error pointer.
Check if the rror pointer isn' tnil, if it is inspect the error

Fetching Objects!
Perform fetches with the class NSFetchRequest
Specicy which entity you are fetching on (can only set one, this is required)
Specify an optional fetch count (default set to fetch all objects)

Faulting

Faulting is a mechamism CoreData employs to reduce your apps memory usage.
A fault is a placeholder object that represents a managed object that ahs not yet been fully realized or a collection that represents a relationship.
A managed fault is an instance of the appropriate cass but its persisent variable are not yet initialized
A relationship fault is the subclass of the collection class that represents the relationship

Fault handling is transparent, thefautl realized only when that variable or relationship is accessed

You can turn realized objects back into faults by calling refreshObjects:mergeChagnes: method on the context.

DESCRIBE VIEW CONTROLLER LIFE CYCLE!
