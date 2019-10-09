.PHONY: e2e build acceptance


build:
	go build -o main .
e2e:
	sh e2e.sh
acceptance:
	sh acceptance.sh
