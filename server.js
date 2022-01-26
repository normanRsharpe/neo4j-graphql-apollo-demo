import { Neo4jGraphQL } from "@neo4j/graphql";
import { ApolloServer } from "apollo-server";
import { driver as _driver, auth } from "neo4j-driver";
import fs from "fs";

// Neo4j driver configuration
const driver = _driver(
  "bolt://localhost:7687",
  auth.basic("neo4j", "password")
);

// Read the generated GraphQL schema
const schemaString = fs.readFileSync("./schema.graphql", "utf8");
const typeDefs = schemaString;

// Create a Neo4jGraphQL instance
const neoSchema = new Neo4jGraphQL({ typeDefs, driver });

// Start the Apollo server
const server = new ApolloServer({
  schema: neoSchema.schema,
});
server.listen().then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
