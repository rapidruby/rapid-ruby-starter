namespace :admin do
  desc "Creates a user account"
  task create_user: :environment do
    puts "First name:"
    first_name = STDIN.gets.strip
    puts "Last name:"
    last_name = STDIN.gets.strip
    puts "Email:"
    email = STDIN.gets.strip
    puts "Password (characters will be hidden):"
    password = STDIN.noecho(&:gets).strip

    user = User.new(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      verified: true,
      admin: true
    )

    user.team = Team.new(name: "#{user.first_name}’s Team")

    if user.save(validate: false)
      user.team.users << user
      puts "User created with email: #{email}"
    else
      puts "Creation failed, please try again"
    end
  end
end
