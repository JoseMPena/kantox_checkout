# Checkout System

This is a Ruby project implementing a checkout system for a supermarket chain. The system allows scanning of products and applies various pricing rules, such as buy-one-get-one-free offers and bulk discounts.

## Prerequisites

To run this project, you will need the following:

- **Ruby**: Version 3.3.1 or later.
- **Bundler**: Gem to manage Ruby project dependencies.
- **Docker** (optional): To run the project in a containerized environment.

## Setup
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/checkout_system.git
   cd checkout_system
   ```

2. **Build the image**:
   ```bash
   make build
   ```

This will create a Docker image named kantox_checkout based on the provided Dockerfile.

3. **Run the project**:
   ```bash
   make run
   ```

### With Docker

### Without Docker

2. **Install dependencies**:
   ```bash
   bundle install
   ```
   
3. **Flag the init script as executable and run it**
    ```bash
    chmod +x bin/checkout
   ./bin/checkout start
    ```

## Running Tests

The project uses RSpec for testing. You can run the tests to ensure everything is functioning correctly.

### Running Tests With Docker
```bash
make test
```

This command will run the tests inside the Docker container.

### Running Tests Without Docker

```bash
bundle exec rspec
```

This command will execute all the tests defined in the spec directory.