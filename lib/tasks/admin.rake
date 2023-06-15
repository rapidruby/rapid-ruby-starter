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
      verified: true
    )

    if user.save(validates: false)
      puts "User created with email: #{email}"
    else
      puts "Creation failed, please try again"
    end
  end
end
