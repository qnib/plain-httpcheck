package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"time"
)

type Health struct {
	Name      string
	Status    int
	Time      time.Time
}

func NewHealth(n string, s int) Health {
	return Health{
		Name: n,
		Status: s,
		Time: time.Now(),
	}
}

func main() {

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", Index)
	router.HandleFunc("/health", ShowHealth)


	log.Fatal(http.ListenAndServe(":8080", router))
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Welcome!\n")
}

func ShowHealth(w http.ResponseWriter, r *http.Request) {
	health := NewHealth("http", 200)
	json.NewEncoder(w).Encode(health)
}

