# Trello API Testing Project

This project is a practical REST API testing project created in Postman for the Trello API.

The main goal of the project is to demonstrate realistic API testing skills, including request validation, dynamic variables, request chaining, automated test execution with Newman and basic continuous integration using Jenkins.

## Project Overview

The Postman collection simulates a complete testing flow for Trello boards, lists and cards.

The collection performs the following actions:

1. Retrieves existing Trello boards
2. Creates a new board
3. Creates a new list on the created board
4. Creates a card on the list
5. Retrieves cards from the board
6. Updates the created card
7. Deletes the card
8. Deletes the test board

The requests are connected into one automated flow. Data created in one request is saved and reused in subsequent requests.

## Tested Areas

The collection includes automated tests for:

* HTTP status codes
* Response body validation
* Response headers
* Response time
* Data types in API responses
* Required response properties
* Correct relation between board, list and card IDs
* Dynamic variables
* Request chaining
* Successful creation, modification and deletion of resources

The tests were written in JavaScript using Postman test scripts.

## Request Chaining

The project uses request chaining to create a dynamic and reusable test flow.

Examples:

* After creating a board, its ID is saved as `boardId`
* After creating a list, its ID is saved as `listId`
* After creating a card, its ID is saved as `cardId`
* Saved IDs are used in subsequent requests to retrieve, update or delete resources

This approach avoids hardcoded resource IDs and makes the collection closer to real API testing performed in a software project.

## Tools Used

* Postman
* Trello REST API
* JavaScript
* Newman CLI
* Jenkins
* Git
* GitHub

## Project Structure

```text
trello-api-postman-tests/
├── collections/
│   └── Trello.postman_collection.json
├── environments/
│   └── Trello.environment-example.json
├── scripts/
│   └── run-newman-from-postman-api.bat
├── README.md
└── .gitignore
```

## Environment Variables

The repository contains an example Postman environment without real API credentials.

Required environment variables:

```text
key = YOUR_API_KEY_HERE
token = YOUR_TOKEN_HERE
```

Example collection variables:

```text
baseUrl = https://api.trello.com/1
boardName = Test Board
listName = Test List
cardName = Test Card
updCardName = Updated Test Card
updDesc = Updated card description
```

Real API keys and tokens are not stored in the repository.

## Running the Collection in Postman

1. Clone or download this repository.
2. Open Postman.
3. Import the collection from the `collections` folder.
4. Import the example environment from the `environments` folder.
5. Add your own Trello API key and token.
6. Select the imported environment.
7. Run the complete collection using Postman Collection Runner.

## Newman Execution

The Postman collection was also executed from the command line using Newman.

In the implemented configuration, Newman retrieved the current collection and environment directly through the Postman API.

The following values were provided as environment variables:

* `POSTMAN_API_KEY`
* `TRELLO_KEY`
* `TRELLO_TOKEN`

Example Newman command:

```bat
newman run "https://api.getpostman.com/collections/COLLECTION_UID" ^
-e "https://api.getpostman.com/environments/ENVIRONMENT_UID" ^
--postman-api-key "%POSTMAN_API_KEY%" ^
--env-var "key=%TRELLO_KEY%" ^
--env-var "token=%TRELLO_TOKEN%"
```

The public batch script available in the `scripts` folder contains placeholders instead of real collection identifiers and credentials.

Newman returns a non-zero exit code when a test fails, allowing an external CI tool to mark the execution as unsuccessful.

## Jenkins Integration

The Newman execution was integrated into a Jenkins Freestyle job.

Jenkins was configured locally using the Jenkins interface and the `Execute Windows batch command` build step.

The Jenkins job:

1. Started the Newman command
2. Retrieved the Postman collection and environment through the Postman API
3. Passed the required Trello and Postman credentials as environment variables
4. Executed the complete API test flow
5. Displayed the Newman test results in the Jenkins console
6. Marked the build as failed when at least one automated test failed

Sensitive values were stored using Jenkins Credentials and were not added directly to the command or committed to GitHub.

The Jenkins job was not connected directly to this GitHub repository. The job configuration was created locally in Jenkins, while this repository stores the Postman collection, example environment and a public version of the Newman execution script.

## Security

The following sensitive values are not stored in the repository:

* Trello API key
* Trello API token
* Postman API key
* Private Postman environment values

The example environment contains placeholders that must be replaced locally.

## Current Status

The project currently includes:

* A working Postman collection
* A complete CRUD-style API test flow
* Automated assertions written in JavaScript
* Dynamic request chaining
* Collection execution using Newman CLI
* Integration with a Jenkins Freestyle job
* Credentials managed using Jenkins Credentials
* A public Newman execution script without sensitive data

## Future Improvements

Possible future improvements include:

* Generating HTML test reports
* Generating JUnit reports for Jenkins
* Adding more negative test scenarios
* Adding tests for invalid authorization
* Adding data-driven tests
* Creating a Jenkins Pipeline using a `Jenkinsfile`
* Connecting Jenkins directly to the GitHub repository
* Automatically triggering tests after repository changes
