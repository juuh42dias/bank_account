# Banking Account - SA

This is a simple banking account system with manage user and accounts, you can create and account with an initial amount, deposit to an account, transfer and check balance from your accounts.


## Index
* [Project dependencies](#project-dependencies)
* [Creating the database user](#creating-database-user)
* [Project Instalation](#project-instalation)
  * [Cloning Project](#cloning-project)
  * [Setup project](#setup-project)
  * [Running tests](#running-tests)
  * [Running app](#running-app)
* [Usage bank](#usage-bank)
* [Api Documentation](#api-documentation)
  * [User endpoint](#user-endpoint)
    * [Create User](#create-user)
    * [Update User](#update-user)
    * [Show User](#show-user)
    * [Delete User](#delete-user)
  * [Account endpoint](#account-endpoint)
    * [Index Account](#index-account)
    * [Create Account](#create-account)
    * [Balance Account](#balance-account)
    * [Deposit Account](#deposit-account)
    * [Transfer Account](#transfer-account)
  * [Authentication Endpoint](#authentication-endpoint)
    * [Login Auth](#login-auth)
* [Contact](#contact)
* [Contributing](#contributing)

## [Project dependencies](#project-dependencies)
* Ruby 2.6.5
* Rails 5.2.3
* PostgreSQL

###Follow these instrunctions to install dependencies

If you use MacOS:  
**Ruby**: https://github.com/rbenv/rbenv#homebrew-on-macos  
**PostgreSQL**: https://www.postgresql.org/download/macosx/  

If you use Ubuntu:  
**Ruby**: https://github.com/rbenv/rbenv-installer#rbenv-installer  
**PostgreSQL**:https://www.postgresql.org/download/linux/ubuntu/
  
## [Creating database user](#creating-database-user)
* `$ sudo -u postgres psql;`
* `$ create role bank_account with createdb login password 'bank_account123';`


## [Project Instalation](#project-instalation)
### [Cloning project](#cloning-project)
* `git clone git@github.com:juuh42dias/bank_account.git`

### [Setup project](#setup-project)
* `bin/setup`

**Execute the bin/setup script. This script will:**

* Verify if the necessary Ruby version is installed
* Install the gems using Bundler
* Create local copies of .env and database.yml
* Create, migrate and populate the database

### [Running tests](#running-tests)
**Run!**  
* Run the `bundle exec rspec` to guarantee that everything is working fine.

### [Running app](#running-app)
* If everything is ok, run `rails server`
you can check app running on http://localhost:3000

## [Usage bank](#usage-bank)  
First of all, do you follow these steps  
* Create an user: [creating user](#create-user)  
* Login user in the app: [logging user](#login-auth)  
* Create an account: [creating an account](#create-account)
  
And be free to [deposit](#deposit-account) (deposit is not required to logged user), to check your [balance](#balance-account), [transfer](#transfer-account) your rich money or [list](#index-account) all your accounts.
  
Enjoy the app!
  

## [Api documentation](#api-documentation)
### [User endpoint](#user-endpoint)
#### [Create User](#create-user)
```
  # Create User POST [/users/]
  + Attributes (object)
    + user
      + name (string)
      + email (string, required)
        Validations: Não pode ficar em branco
      + password (string, required)
        Validations: Não pode ficar em branco

  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
    + Body
        {
          "user":{
            "name": "Testenilda",
            "email": "testenilda@email.com",
            "password": "12345678"
          }
        }
  + Response 201 (application/json)
    + Body
        {
        "id": 2,
        "name": "Testenilda",
        "email": "testenilda@email.com",
        "password_digest": "$2a$12$MRDnfN4MZTCP9xnhicX/Jegi6qINEgGuCd9TBPH7Ze0O1y55Elc6u",
        "created_at": "2020-02-24T10:20:29.783-03:00",
        "updated_at": "2020-02-24T10:20:29.783-03:00",
      }

```

#### [Update User](#update-user)
```
  # Update User PUT [/users/:id]
  + Attributes (object)
    + user
      + name (string)
      + email (string)
      + password (string)

  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
    + Body
        {
          "user":{
            "name": "Testenilda da silva",
            "email": "testenilda@outroemail.com",
            "password": "123456789"
          }
        }
  + Response 200 (application/json)
    + Body
        {
          "id": 1,
          "name": "Testenilda da silva",
          "email": "testenilda@outroemail.com",
          "password_digest": "$2a$12$JUndAmLobAr4lW3gF4IvaeLLhFwINdu1LgBiCwfAtGm91N/tC5w8K",
          "created_at": "2020-02-27T17:02:17.780-03:00",
          "updated_at": "2020-02-27T17:05:39.884-03:00"
        }

```

#### [Show User](#show-user)
```
  # Show User GET [/users/:id]
  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
  + Response 200 (application/json)
    + Body
        {
          "id": 1,
          "name": "Testenilda da silva",
          "email": "testenilda@outroemail.com",
          "password_digest": "$2a$12$JUndAmLobAr4lW3gF4IvaeLLhFwINdu1LgBiCwfAtGm91N/tC5w8K",
          "created_at": "2020-02-27T17:02:17.780-03:00",
          "updated_at": "2020-02-27T17:05:39.884-03:00"
        }

```

#### [Delete User](#delete-user)
```
  # Delete User DELETE [/users/:id]
  + Request (application/json)
    + Headers
            Authorization: Bearer {access_token}

  + Response 204

```

### [Account endpoint](#account-endpoint)
#### [Index Account](#index-account)
```
  # Index Account GET [/accounts/]
  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
  + Response 200 (application/json)
    + Body
        [
          {
            "id": 1,
            "user_id": 1,
            "created_at": "2020-02-27T17:15:40.495-03:00",
            "updated_at": "2020-02-27T17:15:40.495-03:00"
          },
          {
            "id": 2,
            "user_id": 1,
            "created_at": "2020-02-27T17:15:46.854-03:00",
            "updated_at": "2020-02-27T17:15:46.854-03:00"
          }
        ]
```

#### [Create Account](#create-account)
```
  # Create Account POST [/accounts/]
  + Attributes (object)
    + account
      + amount (decimal, required)
        Validations:
          * Amount deve ser um número
          * Amount deve ser maior ou igual a 0

  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
    + Body
        {
          "amount" : 250.50
        }
  + Response 201 (application/json)
    + Body
        {
          "id": 4,
          "user_id": 1,
          "created_at": "2020-02-27T17:21:29.648-03:00",
          "updated_at": "2020-02-27T17:21:29.648-03:00"
        }
```

#### [Balance Account](#balance-account)
```
  # Balance Account GET [/accounts/:account_id/balance]
  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
  + Response 200 (application/json)
    + Body
      {
        "message": "O saldo atual é de: R$ 5.320,50",
        "status": 200
      }
```
#### [Deposit Account](#deposit-account)
```
  # Deposit Account POST [/accounts/deposit]
  + Attributes (object)
    + account
      + amount (decimal, required)
        Validations:
          * Amount deve ser um número
          * Amount deve ser maior ou igual a 0
      + account_id (integer, required)
        Validations:
          * Account_id deve ser um número

  + Request (application/json)
    + Body
        {
          "account_id" : 1,
          "amount": 1510.2
        }
  + Response 200 (application/json)
    + Body
        {
          "message": "Depósito de R$ 1.510,20 efetuado com sucesso",
          "status": 200
        }
```

#### [Transfer Account](#transfer-account)
```
  # Transfer Account POST [/accounts/transfer]
  + Attributes (object)
    + account
      + amount (decimal, required)
        Validations:
          * Amount deve ser um número
          * Amount deve ser maior ou igual a 0
          * Amount não deve ser maior que saldo da conta de origem
      + source_account_id (integer, required)
        Validations:
          * source_account_id deve ser um número
      + destination_account_id (integer, required)
        Validations:
          * destination_account_id deve ser um número

  + Request (application/json)
    + Headers

            Authorization: Bearer {access_token}
    + Body
        {
          "source_account_id": 1,
          "destination_account_id": 2,
          "amount": 550.25
        }
  + Response 200 (application/json)
    + Body
        {
          "message": "Transferida a quantia de R$ 550,25 da conta Nº 1 para conta Nº 2",
          "status": 200
        }
```
### [Authentication Endpoint](#authentication-endpoint)
#### [Login Auth](#login-auth)
```
  # Login Auth POST [/auth/login]
  + Attributes (object)
    + user
      + email (decimal, required)
      + password (integer, required)

  + Request (application/json)
    + Body
        {
          "email": "testenilda@email.com",
          "password": "12345678"
        }
  + Response 200 (application/json)
    + Body
        {
          "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODI4NDExMzksImV4cGlyZSI6MTU4MjkyMDMzOX0.xnglyhOqRgKUC3FUyosmX9TA36trgyNj3wnAwjVutKI",
          "expire": "27/02/2020 19:05",
          "name": "Testenilda"
        }
```

## [Contact](#contact)

[Juliana Dias dos Santos e Silva](juliana.dev) – [@juuh42dias](https://twitter.com/juuh42dias) – <hello@juliana.dev>

[https://gitlab.com/juuh42dias/](https://gitlab.com/juuh42dias)  
[https://github.com/juuh42dias/](https://github.com/juuh42dias/)

## [Contributing](#contributing)

1. Fork it (<https://github.com/juuh42dias/bank_account/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
