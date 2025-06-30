namespace :disposable_email do
  desc "Downloads the latest list of disposable emails"
  task download: :environment do
    data = HTTP.get("https://disposable.github.io/disposable-email-domains/domains.txt").to_s
    path = Rails.root.join("data/disposable_email_domains.txt")

    File.open(path, "w") do |file|
      file.write(data)
    end
  end
end
