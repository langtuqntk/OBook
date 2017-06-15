User.create!(name:  "Anh Nam",
             email: "chinh0510@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             image: "http://file.vforum.vn/hinh/2014/4/chibi-sieu-nhan-gao-11.jpg",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              address: "123 Duy Tan",
              numberphone: "0510921039",
              image: "http://facebook.vnseosem.com/wp-content/uploads/2016/07/13781869_1734111616848579_1226075369885324308_n-150x150.jpg",
              activated_at: Time.zone.now)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

active_type = {act1:"READ", act2:"FAVORITY", act3:"REVIEW", act4:"COMMENT", act5:"FOLLOW",act6:"STATUS"}
active_type.each do |key, value|
  Activity.create!(type_activity: value)
end


50.times do
  Book.create!(title: "English Grammer",
              author: "Nam Cao",
              description: "<i>You are winner!</i>",
              numberpage: "213",
              image: "https://vcdn.tikicdn.com/media/upload/2017/06/07/4c834e73fb024cb23f50b19a849d54aa.png",
              file: "https://pdfobject.com/pdf/sample-3pp.pdf")
end

10.times do
  Request.create!(title: "KLMH",
              contenthtml: "<b>adasdadasd</b>",
              status: 0,
              user_id: 1)
end

(6..10).each do |i|
  RatingBook.create!(rating: 3,
              book_id: 1,
              user_id: i)
end
(1..5).each do |i|
  RatingBook.create!(rating: 4,
              book_id: 1,
              user_id: i)
end

ReviewBook.create!(title: "KLMH",
            contenthtml: "<b>adasdadasd</b>",
            book_id: 5,
            user_id: 5)
