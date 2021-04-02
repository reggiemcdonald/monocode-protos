MOD := github.com/reggiemcdonald/monocode-protos

PROTO_DIR := ${PWD}/proto
OUTPUT_DIR := ${PWD}/pb

.PHONY: go
go:
	rm -rf $(OUTPUT_DIR)/go
	rm -f ${PWD}/go.*
	docker run --rm -v ${PWD}:${PWD} -w ${PWD} znly/protoc \
		--go_out=plugins=grpc:${PWD} \
		--go_opt=module=$(MOD) \
		--proto_path=$(PROTO_DIR) \
		$(PROTO_DIR)/*.proto
	docker run --rm -v ${PWD}:${PWD} -w ${PWD} golang /bin/bash \
		-c "go mod init $(MOD) ; go mod tidy"
