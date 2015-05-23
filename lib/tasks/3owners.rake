desc "Создание 3 пользователей с разными правами"
namespace :owners do
  task :create=>:environment do
    ow1=Owner.create(login: "Admin", password: "administrator",
                     mail: "admin@test.ru", sex: 'м', role: 2)
    ow2=Owner.create(login: "Moderator", password: "moderator",
                     mail: "moder@test.ru", sex: 'м', role: 1)
    ow3=Owner.create(login: "User", password: "usertest",
                     mail: "user@test.ru", sex: 'м', role: 0)
  end
end
