# Bookshop Portfolio (Rails)
A simple bookshop management system built with Ruby on Rails. It supports user authentication, book catalog management, and basic order handling.

## Architecture

In this project, we adopted a **service-oriented architecture (SOA)**, leveraging the power of the `dry-transaction` gem to structure the business logic in a modular and maintainable way. The `dry-transaction` gem is perfect for handling complex workflows and transactions by creating a series of steps (or operations) that can be chained together in a functional manner.

### Why `dry-transaction`?

The `dry-transaction` gem allows us to define business logic steps as isolated operations that can be reused and composed together, ensuring better separation of concerns and promoting a clean architecture. Some of the benefits of using `dry-transaction` include:

- **Clear Separation of Concerns**: Each step in the transaction represents a distinct business rule or operation.
- **Error Handling**: The gem allows us to handle errors gracefully, ensuring the application can recover from failures in any step of the transaction process.
- **Composability**: We can easily compose and reuse the steps across different workflows, making the system flexible and scalable.
- **Testability**: Each operation can be easily tested independently, ensuring that the business logic is reliable and maintainable.

### Example Usage

Here is a brief example of how we implemented a transaction in this project using `dry-transaction`:

```ruby
# app/services/transactions/create_order.rb
class CreateOrder
  include Dry::Transaction

  step :validate_order
  step :process_payment
  step :finalize_order

  def validate_order(input)
    # Validation logic here...
    Success(input)
  end

  def process_payment(input)
    # Payment processing logic here...
    Success(input)
  end

  def finalize_order(input)
    # Finalizing order logic here...
    Success(input)
  end
end
