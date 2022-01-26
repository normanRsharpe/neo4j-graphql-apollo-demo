# Neo4j database first Apollo API

Requirements:

- Neo4j Database instantiated
- node/npm packages installed

Getting Started:

- Run the following command to install the node packages:
  ```
  npm install
  ```
- Seed the database with the Cypher statements in the `initial-seed.cql` file
- Run the following command to introspect the database and create the schema:
  ```
  node introspect.js
  ```
- Run the following command to start the server:
  ```
  node server.js
  ```
- Open the browser to http://localhost:4000
