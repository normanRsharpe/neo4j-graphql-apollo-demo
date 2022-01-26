CREATE (store:Store {name: "test-store", id: apoc.create.uuid()})
CREATE (book:Book {title: "test-book", id: apoc.create.uuid()})
CREATE (author:Author {name: "test-author", id: apoc.create.uuid()})
CREATE (category:Category {name: "test-category", id: apoc.create.uuid()})

CREATE (store)-[:KEEPS {quantity: 10}]->(book)
CREATE (author)-[:WROTE]->(book)
CREATE (book)-[:HAS]->(category)



// More data below





CREATE (s1:Store {name: "Decent Book Store", id: apoc.create.uuid()})
CREATE (s2:Store {name: "Fancy Book Store", id: apoc.create.uuid()})
CREATE (s3:Store {name: "Books-more", id: apoc.create.uuid()})
CREATE (s4:Store {name: "Good Book Store", id: apoc.create.uuid()})

CREATE (b1:Book {title: "The Hobbit", id: apoc.create.uuid()})
CREATE (b2:Book {title: "The Lord of the Rings", id: apoc.create.uuid()})
CREATE (a1:Author {name: "J.R.R. Tolkien", id: apoc.create.uuid()})
CREATE (a1)-[:WROTE]->(b1)
CREATE (a1)-[:WROTE]->(b2)

CREATE (b3:Book {title: "The Catcher in the Rye", id: apoc.create.uuid()})
CREATE (a3:Author {name: "J.D. Salinger", id: apoc.create.uuid()})
CREATE (a3)-[:WROTE]->(b3)

CREATE (b4:Book {title: "The Grapes of Wrath", id: apoc.create.uuid()})
CREATE (a4:Author {name: "John Steinbeck", id: apoc.create.uuid()})
CREATE (a4)-[:WROTE]->(b4)

CREATE (b5:Book {title: "The Great Gatsby", id: apoc.create.uuid()})
CREATE (a5:Author {name: "F. Scott Fitzgerald", id: apoc.create.uuid()})
CREATE (a5)-[:WROTE]->(b5)

CREATE (b6:Book {title: "The Hunger Games", id: apoc.create.uuid()})
CREATE (a6:Author {name: "Suzanne Collins", id: apoc.create.uuid()})
CREATE (a6)-[:WROTE]->(b6)

CREATE (b7:Book {title: "The Da Vinci Code", id: apoc.create.uuid()})
CREATE (a7:Author {name: "Dan Brown", id: apoc.create.uuid()})
CREATE (a7)-[:WROTE]->(b7)

CREATE (b8:Book {title: "The Lion, the Witch and the Wardrobe", id: apoc.create.uuid()})
CREATE (a8:Author {name: "C. S. Lewis", id: apoc.create.uuid()})
CREATE (a8)-[:WROTE]->(b8)

CREATE (c1:Category {name: "Fantasy", id: apoc.create.uuid()})
CREATE (c2:Category {name: "Dystopian", id: apoc.create.uuid()})
CREATE (c3:Category {name: "Historical", id: apoc.create.uuid()})
CREATE (c4:Category {name: "Sci-Fi", id: apoc.create.uuid()})
CREATE (c5:Category {name: "Mystery", id: apoc.create.uuid()})
CREATE (c6:Category {name: "Fiction", id: apoc.create.uuid()})
CREATE (c7:Category {name: "Novel", id: apoc.create.uuid()})
CREATE (c8:Category {name: "Thriller", id: apoc.create.uuid()})

CREATE (b1)-[:HAS]->(c1)
CREATE (b2)-[:HAS]->(c1)
CREATE (b3)-[:HAS]->(c6)
CREATE (b4)-[:HAS]->(c7)
CREATE (b5)-[:HAS]->(c7)
CREATE (b6)-[:HAS]->(c8)
CREATE (b6)-[:HAS]->(c5)
CREATE (b1)-[:HAS]->(c5)
CREATE (b7)-[:HAS]->(c5)
CREATE (b7)-[:HAS]->(c6)
CREATE (b7)-[:HAS]->(c8)
CREATE (b8)-[:HAS]->(c1)

CREATE (s1)-[:KEEPS {quantity: 10}]->(b1)
CREATE (s1)-[:KEEPS {quantity: 0}]->(b2)
CREATE (s1)-[:KEEPS {quantity: 10}]->(b5)
CREATE (s1)-[:KEEPS {quantity: 5}]->(b6)
CREATE (s1)-[:KEEPS {quantity: 0}]->(b7)
CREATE (s1)-[:KEEPS {quantity: 8}]->(b8)

CREATE (s2)-[:KEEPS {quantity: 0}]->(b1)
CREATE (s2)-[:KEEPS {quantity: 10}]->(b2)

CREATE (s2)-[:KEEPS {quantity: 8}]->(b4)
CREATE (s2)-[:KEEPS {quantity: 5}]->(b5)
CREATE (s2)-[:KEEPS {quantity: 0}]->(b6)
CREATE (s2)-[:KEEPS {quantity: 10}]->(b7)
CREATE (s2)-[:KEEPS {quantity: 7}]->(b8)

CREATE (s3)-[:KEEPS {quantity: 0}]->(b1)
CREATE (s3)-[:KEEPS {quantity: 0}]->(b2)
CREATE (s3)-[:KEEPS {quantity: 10}]->(b3)
CREATE (s3)-[:KEEPS {quantity: 10}]->(b4)
CREATE (s3)-[:KEEPS {quantity: 10}]->(b5)
CREATE (s3)-[:KEEPS {quantity: 0}]->(b6)
CREATE (s3)-[:KEEPS {quantity: 0}]->(b8)

CREATE (s4)-[:KEEPS {quantity: 0}]->(b1)
CREATE (s4)-[:KEEPS {quantity: 0}]->(b2)
CREATE (s4)-[:KEEPS {quantity: 0}]->(b3)
CREATE (s4)-[:KEEPS {quantity: 10}]->(b4)
CREATE (s4)-[:KEEPS {quantity: 10}]->(b5)
CREATE (s4)-[:KEEPS {quantity: 0}]->(b7)
CREATE (s4)-[:KEEPS {quantity: 10}]->(b8)


// find a certain book
MATCH (book:Book {title: "The Lion, the Witch and the Wardrobe"})
RETURN book

// find book availability
MATCH (book:Book {title: "The Lion, the Witch and the Wardrobe"})
MATCH (store:Store)-[r:KEEPS]->(book)
WHERE r.quantity > 0
RETURN store, r, book


MATCH (b1: Book {title: 'The Da Vinci Code'})-[:HAS]->(c1: Category)
WITH b1, collect(id(c1)) AS b1Categories
MATCH (b2: Book)-[:HAS]->(c2: Category) where b1 <> b2
WITH b1, b1Categories, b2, collect(id(c2)) AS b2Categories
RETURN b1.title AS from,
       b2.title AS to,
       gds.alpha.similarity.jaccard(b1Categories, b2Categories) AS similarity ORDER BY similarity DESC