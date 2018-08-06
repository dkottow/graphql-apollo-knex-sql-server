console.log('Starting..', new Date().toISOString());

const express = require('express');
const app = express();

try {
  const { apollo, database } = require('./apollo.js');
  apollo.applyMiddleware({ app });
  console.log('Created Database and Apollo server'); 

  //test database
  database.select('Visits', { limit: 2 }).then(visits => { 
    console.log('Connected to Database. Got some rows', visits); 
  });

  database.insert('_Visits', [ { title: "Olimpo", planned_date: "1444-01-01" } ], 'id').then(result => {
    console.log(result); 
  });

} catch(ex) {
  console.log('ERROR - Startup failed.', ex);
}

app.get('/app.config', (req, res) => res.send({
  env: process.env
}));

const port = process.env.PORT || 4000;
app.listen({ port: port }, () =>
  console.log(`Server listening at http://localhost:${port}`),
);
