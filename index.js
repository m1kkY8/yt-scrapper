const play = require("play-dl")
const fs = require("node:fs")
const path = require("node:path")

function load_queries() {
    let queries = fs.readFileSync(path.join(__dirname, "queries"), "utf-8")
    queries = queries.split("\n")
    queries.pop()
    
    fs.writeFileSync(path.join(__dirname, "queries"), "")

    return queries
}

async function search() {
    
    let queries = load_queries()
    
    for (let query of queries) {
        let result = await play.search(query, { limit: 1 })
        console.log(result[0].title);
        console.log(result[0].url);

        fs.appendFileSync(path.join(__dirname, "queries"), result[0].url + "\n")
    }
}

search()
