# BattleShift

This is a brownfield project built on top of a pre-existing battleship game for a single player and computer. In our update layers register for an account, and receive an email with their API key and a link to activate their account. Once activated, they are able to send post requests using their API key to create a new game, place their ships and fire shots on the opposing player.  Both players must be registered users. 

See the project spec here: [Battleshift project spec](http://backend.turing.io/module3/projects/battleshift)

## Getting Started

1. clone down this project and change into the directory
```
git clone https://github.com/memcmahon/battleshift.git
bundle install
```
2. create and migrate the database
```
rake db:create
rake db:migrate
```
3. create an active user in the database
```
rails c
User.create(name: "give it a name", email: "give in an email", password: "give it a password", password_confirmation: "same password", status: 1)
exit
```
4. Run rails server and visit the port indicated in your browser
```
rails s
```

### Requirements

* Ruby 2.4+
* Rails 5
