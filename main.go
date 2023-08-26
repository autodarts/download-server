package main

import (
	"log"
	"net/http"
)

func main() {
	http.Handle("/", http.RedirectHandler("https://raw.githubusercontent.com/autodarts/releases/main/install.sh", 301))
	http.Handle("/uvc", http.RedirectHandler("https://raw.githubusercontent.com/autodarts/releases/main/uvc/install.sh", 301))
	http.Handle("/win", http.RedirectHandler("https://raw.githubusercontent.com/autodarts/releases/main/install.ps1", 301))
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
