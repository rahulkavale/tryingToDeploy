# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Item.delete_all
Item.create!(:title => 'Coke', :description => 'The soft drink for everyone', :price => 15)
Item.create!(:title => 'Mac Book pro', :description => 'The ultimate laptop from apple thats fits your needs', :price => 150000)
Item.create!(:title => 'Galaxy III', :description => 'The next generation mobile', :price => 31000)
Item.create!(:title => 'Mac book air', :description => 'The lightweight laptop from Apple', :price => 100000)
Item.create!(:title => 'Dell inspiron', :description => 'The dell laptop', :price => 30000)
Item.create!(:title => 'Bat', :description => 'good bat', :price => 1500)

