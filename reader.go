package main

import (
    "fmt"
    "os"
    "bufio"
)

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func main() {
    
    // get directory in which dis file is placed
    

    input := ""
    
    file, err := os.OpenFile("/home/tox/projects/yt-scraper/queries", os.O_APPEND | os.O_CREATE | os.O_RDWR, 0644)
    check(err)

    for {

        fmt.Print("Enter song: ")
        reader := bufio.NewReader(os.Stdin)

        line, err := reader.ReadString('\n')
            check(err)
        
        input = line[:len(line)-1]
        
        if input == "exit" {
            return
        }

        _, err = file.WriteString(input + "\n")
        check(err)
        
        

    }
}   
