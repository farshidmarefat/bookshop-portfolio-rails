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
```

# Authentication with Devise and JWT

This application uses **Devise** along with **JWT (JSON Web Tokens)** for user authentication. Below is an explanation of how the authentication is set up in this application.

## Overview

- **Devise** is used for user registration and login functionalities.
- **JWT** is used for token-based authentication to protect API routes and manage sessions without relying on cookies.

## Setup

### 1. Devise Setup
Devise is configured to use JWT for handling authentication. JWT tokens are generated upon successful user registration or login and are required for accessing authenticated routes.

In the `config/initializers/devise.rb` file, the JWT settings are configured as follows:

```ruby
Devise.setup do |config|
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_secret_key || ENV['DEVISE_JWT_SECRET_KEY']
    jwt.dispatch_requests = [['POST', %r{^/api/v1/users/sign_in$}]]
    jwt.revocation_requests = [['DELETE', %r{^/api/v1/users/sign_out$}]]
    jwt.expiration_time = 2.hours.to_i
  end
end
```
The secret key is fetched from Rails credentials or environment variables (DEVISE_JWT_SECRET_KEY).
JWT tokens are generated upon POST /api/v1/users/sign_in and can be invalidated using DELETE /api/v1/users/sign_out.

### 2.User Registration
To create a new user, send a `POST` request to `/api/v1/users` with the user parameters (e.g., email, password). Upon successful registration, a JWT token is returned:
```ruby
{
  "token": "your.jwt.token"
}
```
The `create` action in `RegistrationsController` handles user registration:
```ruby
def create
  user = User.new(sign_up_params)

  if user.save
    token = user.generate_jwt
    render json: token.to_json
  else
    render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  end
end
```
### 3. User Login
To log in, send a `POST` request to `/api/v1/users/sign_in` with the user's email and password. If the credentials are valid, a JWT token is returned:
```ruby
def create
  user = User.find_by_email(params[:email])

  if user && user.valid_password?(params[:password])
    token = user.generate_jwt
    render json: token.to_json
  else
    render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  end
end
```
### 4. Authentication in API Requests
To access protected routes, include the JWT token in the `Authorization` header of the request. The token should be prefixed with `Bearer`.
In the controller, the `process_token` method decodes the token and sets the current user:
```ruby
def process_token
  if request.headers['Authorization'].present?
    begin
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e
      logger.error "JWT decode error: #{e.message}"
      head :unauthorized
    end
  end
end
```
### 5. Accessing the Current User
The `current_user` method is used to access the authenticated user in controllers. It fetches the user from the database using the decoded JWT payload:
```ruby
def current_user
  @current_user ||= User.find(@current_user_id) if @current_user_id
end
```
### 6. Protected Routes
To protect routes and ensure only authenticated users can access them, use the `before_action :authenticate_user!` filter in your controllers. For example, in `UsersController`:
```ruby
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: current_user, except: [:password_digest]
      end
    end
  end
end
```
The `authenticate_user!` method ensures that the user is authenticated and has a valid JWT token.

