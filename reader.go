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

    input := ""
    
    currentDir, err := os.Getwd()
    check(err)
    queriesFile := currentDir + "/queries"

    file, err := os.OpenFile(queriesFile, os.O_APPEND | os.O_CREATE | os.O_RDWR, 0644)
    check(err)

    for {
        fmt.Print("Enter song: ")
        reader := bufio.NewReader(os.Stdin)

        line, err := reader.ReadString('\n')
            check(err)
        
        input = line[:len(line)-1]
        
        if input == "exit" {
            defer file.Close()
            return
        }

        _, err = file.WriteString(input + "\n")
        check(err)
    }
}   
