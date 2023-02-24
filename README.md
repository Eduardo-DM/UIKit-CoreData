# UIKit-CoreData

Recreate the CRUD cycle for an entity that represents the basic data for a board game in the context of an app which goal is be a library for this kind of products.

### UIKit

UIKit is the framework for the UI. Some cool solutions are implemented such us:

- An extension of native controls to get a reusuable behabiour for a component (e.g. an alert)

<img width="1244" alt="image" src="https://user-images.githubusercontent.com/93383384/221189144-184dee1a-363f-414e-b8cd-f3af481d1609.png">

- A custom component

<img width="701" alt="image" src="https://user-images.githubusercontent.com/93383384/221188898-1fdbe056-a0dd-4f31-afaa-12f4c078b468.png">

### Core data

Core Data is used for the persistence of data.

### Design pattern

Command pattern is used for the run the logic.

<img width="574" alt="image" src="https://user-images.githubusercontent.com/93383384/221193180-22fabc71-4aaf-4772-a588-b3faa00f5514.png">

### TDD

Everything is developed carrying a TDD aproach with unitary test to validate every single operation. We can see a check for right error generation:

<img width="1187" alt="image" src="https://user-images.githubusercontent.com/93383384/221189450-e2d6eacb-4e54-4975-b31e-d35b82b9e381.png">
