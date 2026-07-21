# Trello REST API Tests — Postman, Newman and Jenkins

This repository contains a practical REST API testing project created for the Trello API.

The project demonstrates API request validation, automated assertions, dynamic variables, request chaining, command-line collection execution with Newman and basic continuous integration using a Jenkins Freestyle job.

## Project Overview

The Postman collection performs a connected CRUD-style test flow for Trello boards, lists and cards.

The automated flow:

1. Retrieves existing Trello boards
2. Creates a new board
3. Creates a new list on the board
4. Creates a new card on the list
5. Retrieves cards from the board
6. Updates the created card
7. Deletes the card
8. Deletes the test board

Resources created during the test run are saved as collection variables and reused in subsequent requests.

This makes the collection independent of hardcoded board, list and card identifiers.

## Tested API Operations

| Method   | Operation                                           |
| -------- | --------------------------------------------------- |
| `GET`    | Retrieve boards belonging to the authenticated user |
| `POST`   | Create a new board                                  |
| `POST`   | Create a new list                                   |
| `POST`   | Add a card to a list                                |
| `GET`    | Retrieve cards from a board                         |
| `PUT`    | Update a card                                       |
| `DELETE` | Delete a card                                       |
| `DELETE` | Delete a board                                      |

## Automated Test Coverage

The collection contains JavaScript test scripts created in Postman.

The automated checks include:

* HTTP status code validation
* Response body validation
* Response header validation
* Response time validation
* Response property validation
* Data type validation
* Board, list and card relationship validation
* Created resource name validation
* Updated card name and description validation
* Dynamic ID extraction
* Request chaining
* Resource cleanup after test execution

## Request Chaining

The collection uses dynamic variables to connect requests into one automated flow.

The following identifiers are saved during execution:

* `boardId` after creating a board
* `listId` after creating a list
* `cardId` after creating a card

The saved values are then used in later requests.

Example flow:

```text
Create board
    ↓ save boardId
Create list
    ↓ save listId
Create card
    ↓ save cardId
Get and update card
    ↓
Delete card
    ↓
Delete board
```

This approach avoids hardcoded resource IDs and represents a realistic API testing workflow.

## Tools and Technologies

* Postman
* Trello REST API
* JavaScript
* Newman CLI
* Jenkins
* Git
* GitHub
* Windows Batch

## Project Structure

```text
trello-api-postman-tests/
├── collections/
│   └── Trello.postman_collection.json
├── environments/
│   └── Trello.environment-example.json
├── scripts/
│   └── run-newman-from-postman-api.bat
├── .gitignore
└── README.md
```

## Required Credentials

To execute the tests, you need:

* A Trello API key
* A Trello API token

The repository contains an example Postman environment with placeholder values:

```text
key = YOUR_KEY_HERE
token = YOUR_TOKEN_HERE
```

Replace these placeholders locally or provide the credentials through Newman environment variables.

Real API keys and tokens are not stored in this repository.

## Running the Collection in Postman

1. Clone or download this repository.
2. Open Postman.
3. Import:

```text
collections/Trello.postman_collection.json
```

4. Import:

```text
environments/Trello.environment-example.json
```

5. Add your Trello API key and token to the imported environment.
6. Select the imported environment in Postman.
7. Open the collection.
8. Run the complete collection using Postman Collection Runner.

The requests should be executed in their existing order because later requests use identifiers created by earlier requests.

## Running the Collection Locally with Newman

### 1. Install Newman

Newman can be installed globally using npm:

```bash
npm install -g newman
```

Verify the installation:

```bash
newman --version
```

### 2. Run the Exported Collection

From the main project directory, run:

```bat
newman run "collections/Trello.postman_collection.json" -e "environments/Trello.environment-example.json" --env-var "key=YOUR_TRELLO_KEY" --env-var "token=YOUR_TRELLO_TOKEN"
```

Replace:

```text
YOUR_TRELLO_KEY
YOUR_TRELLO_TOKEN
```

with your own credentials.

The values passed through `--env-var` override the placeholder values stored in the example environment file.

### Windows Multiline Version

The same command can be written as a multiline Windows Batch command:

```bat
newman run "collections/Trello.postman_collection.json" ^
-e "environments/Trello.environment-example.json" ^
--env-var "key=YOUR_TRELLO_KEY" ^
--env-var "token=YOUR_TRELLO_TOKEN"
```

This method executes the collection exported to this GitHub repository.

## Newman Execution Through the Postman API

During the Jenkins integration, Newman retrieved the current Postman collection and environment directly through the Postman API.

This allowed Jenkins to execute the latest saved version from Postman without manually exporting the collection after every change.

The following values were passed to the Newman command:

* `POSTMAN_API_KEY`
* `TRELLO_KEY`
* `TRELLO_TOKEN`

Example command:

```bat
newman run "https://api.getpostman.com/collections/COLLECTION_UID" ^
-e "https://api.getpostman.com/environments/ENVIRONMENT_UID" ^
--postman-api-key "%POSTMAN_API_KEY%" ^
--env-var "key=%TRELLO_KEY%" ^
--env-var "token=%TRELLO_TOKEN%"
```

The public example script is available here:

```text
scripts/run-newman-from-postman-api.bat
```

The script contains placeholders instead of real collection identifiers and credentials.

## Jenkins Integration

The Newman command was integrated into a locally configured Jenkins Freestyle job.

Jenkins used the following build step:

```text
Execute Windows batch command
```

The Jenkins job:

1. Started the Newman command
2. Retrieved the current collection through the Postman API
3. Retrieved the current environment through the Postman API
4. Passed the required Postman and Trello credentials
5. Executed the complete API test collection
6. Displayed Newman results in Jenkins Console Output
7. Marked the build as failed when an automated test failed

The implemented flow was:

```text
Postman API
    ↓
Jenkins Freestyle Job
    ↓
Windows Batch Command
    ↓
Newman CLI
    ↓
Trello REST API Tests
```

The Jenkins job was configured locally through the Jenkins interface.

Jenkins was not connected directly to this GitHub repository, and the project did not use a `Jenkinsfile`.

This repository documents the implemented process and stores:

* The exported Postman collection
* The example Postman environment
* A public version of the Newman execution script
* Project documentation

## Credential Management

Sensitive credentials used by the Jenkins job were managed using Jenkins Credentials.

The following values were not hardcoded in the public script:

```text
POSTMAN_API_KEY
TRELLO_KEY
TRELLO_TOKEN
```

They were provided to the Newman command as environment variables.

The repository does not intentionally store:

* Trello API keys
* Trello API tokens
* Postman API keys
* Private environment files
* Passwords
* Jenkins credential values

## Newman Exit Codes

Newman returns a non-zero exit code when at least one request or automated assertion fails.

Because of this behavior, Jenkins can automatically distinguish between:

```text
Successful Newman execution → successful Jenkins build
Failed Newman test         → failed Jenkins build
```

This enables the API collection to function as part of a basic continuous integration process.

## Current Project Status

The project currently includes:

* A working Trello API Postman collection
* Eight connected API requests
* A complete CRUD-style test flow
* JavaScript assertions
* Dynamic request chaining
* Collection variables
* Postman Collection Runner execution
* Local command-line execution with Newman
* Newman execution through the Postman API
* Integration with a Jenkins Freestyle job
* Jenkins Credentials usage
* Automatic Jenkins build failure after a failed Newman test
* A public execution script without sensitive credentials

## Future Improvements

Planned improvements may include:

* Testing invalid authorization
* Testing missing required parameters
* Adding data-driven testing with CSV or JSON files
* Generating Newman HTML reports
* Generating JUnit XML reports
* Publishing test reports in Jenkins
* Adding a cleanup script that runs after unexpected failures
* Creating a Jenkins Pipeline using a `Jenkinsfile`
* Connecting Jenkins directly to the GitHub repository
* Automatically triggering tests after repository changes
