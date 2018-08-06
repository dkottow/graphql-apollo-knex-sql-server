
var knex = require('knex');

//abstract Database object using Knex SQL wrapper
class Database {

    constructor() {
        this.config = {
            maxLimit: 1000
        };
    }

    parseWhere(wc) {
        var result = {
            field: wc.field,
            op: WHERE_OPS[wc.op],
            value: wc.value || wc.values
        }
        return result;
    }

    select(view, filter = {}) {
        let query = this.db(view).select();

        let whereClauses = filter.where || [];
        whereClauses.forEach((wc) => {
            wc = this.parseWhere(wc);
            query = query.where(wc.field, wc.op, wc.value);
        });

        let orderByClauses = filter.orderBy || [];  
        orderByClauses.forEach((oc) => {
            query = query.orderBy(oc.field, oc.dir);
        });

        let limit = Math.min(filter.limit || 1e9, this.config.maxLimit);
        query.limit(limit);

        console.log('SQL', query.toString());
        return query;
    }
 
    insert(table, rows, ret) {
        return Promise.all(rows.map(row => {
            let q = this.db(table).insert(row, ret).then(results => {
                return results[0];
            });
            console.log('SQL', q.toString());
            return q;
        }));
    }

    update(table, rows) {
        console.log('update', rows);
        return; 
    }
}

//concrete Database classes are tied to a SQL engine

class DatabaseSqlite extends Database {
    constructor(filename) {
        super();
        this.db = knex({ 
            client: 'sqlite3',
            connection: {
                filename: filename 
            } 
        });
    }
}

class DatabasePostgreSQL extends Database {
    constructor(conn) {
        super();
        this.db = knex({ 
            client: 'pg',
            connection: conn        
        });
    }
}

const WHERE_OPS = {
    EQ: '=',
    GT: '>',
    GE: '>=',
    LT: '<',
    LE: '<=',
    IN: 'in',
    BTWN: 'between',
    LIKE: 'like'
};

module.exports = { DatabaseSqlite, DatabasePostgreSQL };