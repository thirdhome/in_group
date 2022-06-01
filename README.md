# InGroup

InGroup allows you to easily segment your ActiveRecord models into named groups without making database changes.

Its existence is best framed by a story. Someone from sales comes to you with a request that seems simple:
your company's best customer needs a site experience that is just a _little_ different. It turns out this particular
customer dislikes blue buttons and has requested green buttons.

At first you think, "I'll build a new green button feature. I'll add a column for it, and then I'll look for that
configuration in the application code. When it ships I'll flag this customer into this behavior." Totally doable in
Rails...

Then you look at your massive schema.rb, and all the old underused moldering columns and you think: "It's just
one User. Maybe I should just hard-code it." But hard-coding User ID 12345 into your application logic just feels
wrong... 🤔

InGroup is intended to fill this gap. It allows you to define named criteria-based groups of your models for these cases.
Yeah, you're still hard-coding, but these hard-codings are rendered into named groups so that your application logic can
deal with them in an abstract way. No extra columns or database changes required.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add in_group

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install in_group

## Usage

```ruby
# Define groups on your ActiveRecord class as follows.
# (We recommend doing this in your class definition
# `InGroup.define(self)` so that Rails class-loading works
# as expected.)
InGroup.define(User) do |groups|
  groups.add(:prefers_green_buttons, id: 12345)
end

# Query records in a group like so:
User.in_group(:prefers_green_buttons)

# Interrogate instances for group membership.
# (This will perform attr comparisons and will not
# query the database.)
user.in_group?(:prefers_green_buttons)

# If more users want green buttons, just update the
# group definition.
InGroup.define(User) do |groups|
  groups.add(:prefers_green_buttons, id: [12345, 1, 1_000_000])
end

# Does every US-based customer named Steve also
# prefer green buttons? We can do that too.
InGroup.define(User) do |groups|
  groups.add(:prefers_green_buttons, id: [1, 12345, 1_000_000])
  groups.add(:prefers_green_buttons, first_name: "Steve", country: "US")
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run the tests like so:

    DB=mysql2://db_user:db_password@localhost:3306/in_group_test rake test

where DB is a valid URI string for connecting to a local database. Run `rake standard` to verify changes
match the Ruby styleguide.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thirdhome/in_group. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/thirdhome/in_group/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InGroup project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/thirdhome/in_group/blob/main/CODE_OF_CONDUCT.md).
