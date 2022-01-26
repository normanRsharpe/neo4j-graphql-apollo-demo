import { toGraphQLTypeDefs } from "@neo4j/introspector";
import { driver as _driver, auth, session } from "neo4j-driver";
import { writeFileSync } from "fs";

// Neo4j driver configuration
const driver = _driver(
  "neo4j://localhost:7687",
  auth.basic("neo4j", "password")
);

// instantiate the database session
const sessionFactory = () =>
  driver.session({ defaultAccessMode: session.READ });

// Query the database and generate the GraphQL schema
async function main() {
  const typeDefs = await toGraphQLTypeDefs(sessionFactory);
  writeFileSync("schema.graphql", typeDefs);
  await driver.close();
}
main();
