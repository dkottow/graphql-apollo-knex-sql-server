const fs = require('fs');
const { ApolloServer, gql } = require('apollo-server-express');
const { GraphQLDate, GraphQLTime, GraphQLDateTime } = require('graphql-iso-date');
const { DatabaseSqlite, DatabasePostgreSQL } = require('./database.js');

//var db = new DatabaseSqlite('./test.sqlite');
const database = new DatabasePostgreSQL({
    host : 'test-free.cxqqlyadnoml.us-west-2.rds.amazonaws.com',
    user : 'dkottow',
    password : 'W3AmazonWS',
    database : 'simpliroute'
});

// Type definitions define the "shape" of your data and specify
// which ways the data can be fetched from the GraphQL server.
const typeDefsGraphQL = fs.readFileSync('./simpliroute.graphql', 'utf8');
const typeDefs = gql(typeDefsGraphQL);

function serializeDates(row, inputTypeName) {
  const dateFields = typeDefs.definitions.find(def => {
    return def.name.value == inputTypeName;
  }).fields.filter(field => {
    return field.type.name.value == "Date";
  });
  dateFields.forEach(field => {
    let fn = field.name.value;
    row[fn] = GraphQLDate.serialize(row[fn]);
  });
  return row;  
}
// Resolvers define the technique for fetching the types in the
// schema.  We'll retrieve visit by querying database obj.
const resolvers = {
  Query: {
    visits: (obj, args, context, info) => {
      return database.select('Visits', args.filter);
    }
  },
  
  Mutation: {
    visitsInsert: (obj, args, context, info) => {
      let visits = args.visits.map(row => {
        return serializeDates(row, 'VisitInput');
      });
      return database.insert('_Visits', visits, 'id').then(result => {
        //TODO ? return objects
        return result; 
      });
    },

    visitUpdate: (obj, args, context, info) => {
      let visit = serializeDates(args.visit, 'VisitInput');
      return database.update('_Visits', args.visit);
    }
  },
  Date: GraphQLDate,
  DateTime: GraphQLDateTime
};

//Apollo GraphQL Playground UI settings (needed to workaround cursor bug)
const playground = {
    settings: {
      'editor.theme': 'light',
      'editor.cursorShape': 'line' // possible values: 'line', 'block', 'underline'
    }
};

// In the most basic sense, the ApolloServer can be started
// by passing type definitions (typeDefs) and the resolvers
// responsible for fetching the data for those types.
const apollo = new ApolloServer({ typeDefs, resolvers, playground });

module.exports = { apollo, database };