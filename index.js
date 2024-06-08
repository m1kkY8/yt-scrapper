const play = require("play-dl")
const fs = require("node:fs")
const path = require("node:path")

async function search(query) {
    let result = await play.search(query)

    console.log(result[0].title);
    console.log(result[0].url);

    //write the url to a file
    fs.appendFileSync(path.join(__dirname, "music_links"), result[0].url + "\n")

}

const readline = require("node:readline")

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
})

function getSong() {
    rl.question("Enter a song name: ", async function (query) {
        if (query === "exit") {
            rl.close()
        }

        await search(query)
        getSong()
    })

    rl.on("close", function () {
        process.exit(0)
    })
}

getSong()
