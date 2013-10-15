# coding: utf-8

ActiveRecord::Base.transaction do
  ["Cursos", "Proyectos"].each do |category_name|
    category =
      Category.create!(
        :title => category_name,
        :text => Faker::Lorem.paragraphs.join("\n")
      )

    rand(1..2).times do |index|
      category.pics.create!(
        :attach => File.open("#{Rails.root}/test/fixtures/pic.jpg")
      )
    end

    puts "Created category [#{category.id}] – #{category.title}"
  end


  20.times do |index|
    item =
      Item.create!(
        :title => Faker::Lorem.sentence,
        :intro => Faker::Lorem.sentence,
        :text => Faker::Lorem.paragraphs.join("\n"),
        :category => Category.all.sample
      )

    rand(5).times do |index|
      item.pics.create!(
        :attach => File.open("#{Rails.root}/test/fixtures/pic.jpg")
      )
    end

    puts "Created item [#{item.category.title}][#{item.id}] – #{item.title}"
  end

  email = "admin@email.com"
  password = "pass"
  admin_user =
    AdminUser.create!(
      :name => "Super Admin",
      :email => email,
      :password => password,
      :password_confirmation => password
    )

  puts "AdminUser created #{email}/#{password}"
end