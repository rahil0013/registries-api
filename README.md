## Background

Your team is responsible for maintaining a registry of hosts and URLs that redirect to designated destinations.

Examples of registry entries:

| **Source** | **Destination** |
| --- | --- |
| domain.net/old_page.html | domain.net/new_page.html |
| old.site.com | new.site.com |
| example.org | www.example.org |


The task is to make this registry accessible via an HTTP JSON API.

A typical entry in the registry has the following structure (all fields required):

* URL to redirect from (“source”)
* Destination URL to redirect to (“destination”)
* Status (one of Active, Inactive, or Scheduled)
* Confidential (true/false)
* Created At
* Updated At

## Requirements

Via the developed API, one must be able to:

a) Retrieve a listing of all current registry entries.

b) Retrieve a single registry entry by its internal ID.

c) Retrieve all current registry entries matching a “filter” string on the source URL .
For example, filtering for ‘omai’ should retrieve “domain.net/old_page.html” and other matching entries, but not “old.site.com”.

d) Update any registry entry’s status from its current status to any of the three permitted options (Active, Inactive or Scheduled)


<br />

Important: A Confidential registry entry should never have the following fields returned by the API:
* Destination URL
* Status
* Updated At timestamp


## Considerations

* Anonymous access is all that is necessary to connect to the API via these four ways, and retrieve JSON responses. No form of login nor authentication is required.

* Any creation or alteration of a registry entry must be simultaneously timestamped in the “Created At” and “Updated At” fields.

* Your solution must contain a docker manifest so we can run your application in containers. While your submission will still be considered without a docker manifest/definition, the presence of a working docker manifest counts significantly in overall consideration of your submission.


## Submission Instructions

* This private repo has been created just for you. Please push your code to it and notify your urllo recruiting contact when you’re done! You are free to alter the contents of this repo in any way you please.


* This repo contains a “seed” JSON file as a starting point for registry entries, to load into any backend data storage mechanism you prefer. You may add to, or edit, the seed data if you prefer. Dates and times in the seed file are represented in the [ISO 8601 standard](https://fits.gsfc.nasa.gov/iso-time.html).

* Submission shall utilize Ruby/Rails.



--------


# Registry API README

This README provides instructions for setting up, running, and using the Registry API. It also includes steps to containerize the application using Docker.

## Requirements
- ruby 3.4.1
- Rails 8.0.1
- sqlite3
- Docker (if running as a container)

---

## Steps to Set Up and Run Locally

### Step 1: Clone the Repository
Clone the repository to your local machine:
```bash
git clone https://github.com/rahil0013/registries-api.git
cd <repository-folder>
```

### Step 2: Install Dependencies
Run the following commands to install Ruby and Rails dependencies:
```bash
bundle install
```

### Step 3: Configure the Database
1. Create a `.env` file or update `config/database.yml` to change your database settings if you wish.
2. Run database migrations:
   ```bash
   rails db:create db:migrate
   ```

### Step 4: Seed Data (Optional)
Seed the database with initial data: This will feed seed_data.json into DB.
```bash
rails db:seed
```

### Step 5: Start the Server
Run the Rails server locally:
```bash
rails server
```
The API will be available at `http://localhost:3000`.

---

## API Endpoints

### Base URL
The API's base URL is `http://localhost:3000/registries`.

### Endpoints
1. **List All Registries**:
   ```bash
   GET /registries
   ```

2. **Filter Registries by Source URL**:
   ```bash
   GET /registries?filter=<search-param>
   ```

3. **Get a Registry by id**:
   ```bash
   GET /registries/:id
   ```

4. **Create a New Registry**:
   ```bash
   POST /registries
   Content-Type: application/json

   {
     "source": "http://example.com",
     "destination": "http://example.net",
     "status": "active",
     "confidential": false
   }
   ```

5. **Update a Registry**:
   ```bash
   PATCH /registries/:id
   Content-Type: application/json

   {
     "status": "scheduled"
   }
   ```

6. **Delete a Registry**:
   ```bash
   DELETE /registries/:id
   ```

---

## Steps to Run as a Docker Container

### Step 1: Build the Docker Image

Build the Docker image:
```bash
docker-compose build
```

### Step 2: Run
Start the container with the following command:
```bash
docker-compose up
```

### Step 3: Access the API
The API will be accessible at `http://localhost:3000`.

---

## Testing the Application
Use CURL, or any HTTP client to test the endpoints. Examples below:

```bash
# POST request to create a new registry
curl -X POST http://localhost:3000/registries \
-H "Content-Type: application/json" \
-d '{
  "source": "http://rahilexample.com",
  "destination": "http://newexample.net",
  "status": "active",
  "confidential": false
}'

# PATCH request to update the status of a registry
curl -X PATCH http://localhost:3000/registries/1 \
-H "Content-Type: application/json" \
-d '{
  "status": "inactive"
}'

# DELETE request to delete a registry with ID 1
curl -X DELETE http://localhost:3000/registries/1 \
-H "Content-Type: application/json"

```


