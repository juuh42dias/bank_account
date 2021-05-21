# Banking Account - SA

![rspec](https://ruby.ci/badges/9fec11b5-097d-427b-bbdf-757c2aa25902/rspec)

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
* [Api Documentation](https://github.com/juuh42dias/bank_account/wiki/API-Documentation)
* [Contact](#contact)
* [Contributing](#contributing)

## [Project dependencies](#project-dependencies)
* Ruby 2.6.5
* Rails 5.2.3
* PostgreSQL

### Follow these instrunctions to install dependencies

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
