# Trello API Testing Project

This project is a practical API testing project created in Postman for the Trello REST API.

The main goal of this project is to demonstrate basic but realistic API testing skills, including request validation, dynamic variables, request chaining and a complete CRUD-style test flow.

## Project Overview

The collection simulates a real testing flow for Trello boards, lists and cards.

It covers the following scenario:

1. Get existing boards
2. Create a new board
3. Create a new list on the created board
4. Add a card to the created list
5. Get cards from the board
6. Update the created card
7. Delete the card
8. Delete the board

This structure allows the collection to be executed as one connected flow, where data created in one request is reused in the next requests.

## Tested Areas

The Postman collection includes tests for:

* HTTP status codes
* Response body validation
* Response headers
* Response time
* Data types in API responses
* Correct relation between board, list and card IDs
* Dynamic variables
* Request chaining

## Request Chaining

The project uses request chaining to make the collection more dynamic and reusable.

Examples:

* After creating a board, its ID is saved as `boardId`
* After creating a list, its ID is saved as `listId`
* After creating a card, its ID is saved as `cardId`
* Saved IDs are used in the next requests, for example to update or delete the created resources

This approach avoids hardcoded IDs and makes the collection closer to real API testing practice.

## Tools Used

* Postman
* Trello REST API
* JavaScript test scripts in Postman
* GitHub

Planned next steps:

* Newman for command-line test execution
* Jenkins for basic CI/CD integration
* Automated test reports

## Project Structure

```txt
trello-api-postman-tests/
├── collections/
│   └── Trello.postman_collection.json
├── environments/
│   └── Trello.environment-example.json
├── README.md
└── .gitignore
```

## Environment Variables

The project uses an example environment file without real API credentials.

Required environment variables:

```txt
key = YOUR_API_KEY_HERE
token = YOUR_TOKEN_HERE
```

Example collection variables:

```txt
baseUrl = https://api.trello.com/1
boardName = Test Board
listName = Test List
cardName = Test Card
updCardName = Updated Test Card
updDesc = Updated card description
```

## How to Run

1. Clone or download this repository.
2. Open Postman.
3. Import the collection from the `collections` folder.
4. Import the environment from the `environments` folder.
5. Add your own Trello API key and token.
6. Select the correct environment in Postman.
7. Run the collection manually or with Collection Runner.

## Current Status

The project currently includes a working Postman collection with API requests, tests, variables and request chaining.

The next stage of development will include Newman execution and Jenkins CI/CD integration.
