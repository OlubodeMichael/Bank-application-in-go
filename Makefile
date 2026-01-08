postgres:
	docker run --name postgres17 -p 5431:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:17-alpine

createdb:
	docker exec -it postgres17 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres17 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" down

sqlc:
	sqlc generate
test:
	go test -v -cover ./...

server:
	go run main.go
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server