build:
	docker build -t kantox_checkout .

run:
	docker run --rm -it kantox_checkout ./bin/checkout start

test:
	docker run --rm kantox_checkout bundle exec rspec