# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Testing Inventory

**Objective:** Use TDD in Rails to create an inventory management application. Your goal is to write code to pass the tests.

## Getting Started

1. Fork this repo, and clone it into your `develop` folder on your local machine.
2. Run `bundle install` to install gems.
3. Run `rake db:create db:migrate` to create and migrate the database.
4. Start your Rails server.
5. Run `rspec` in the Terminal. You should see an angry error message. Your job is to fix it!

## Part 1: Products

* The failing specs are for a `ProductsController`. For the first part of this lab, implement the functionality for the `ProductsController` to pass the tests. **Some tips:**
  * Read the errors carefully. They will guide you as to what to do next.
  * Once you've gotten past the initial setup errors, and you have failing specs printing out in the Terminal, it may help to comment-out some of the specs to narrow in on what you're working on. Comment them back in when you're ready to work on them.
* You DON'T need to implement fully-functioning views, but you can if you want to.
* Once you have all the specs passing for the `ProductsController`, it's time to implement a unit test for products:
  * Products should have an instance method called `#margin` that calculates the <a href="http://retail.about.com/od/glossary/g/margin.htm" target="_blank">retail margin</a>.
  * **Write the spec for `#margin` before implementing the method!**
  * **Hint:** `rails g rspec:model product`

Feel free to reference the [solution branch](https://github.com/sf-wdi-24/testing_inventory/tree/solution) for guidance.

## Part 2: Items

* A product should **have many items**. Use TDD to guide your implementation of CRUD for items. Follow the examples in `spec/controllers/products_controller_spec.rb` as a guide for testing your `ItemsController`.
* Items should have a minimum of three attributes: `size`, `color`, and `status`. Validate these three attributes for `presence`.
* Items routes should be nested under products routes. See the <a href="http://guides.rubyonrails.org/routing.html#nested-resources" target="_blank">Rails docs for nested resources</a>.
* Your `ItemsController` doesn't need an `#index` method, since your app should display all of a product's items on the `products#show` page. However, it should have the other six methods for RESTful routes (`#new`, `#create`, `#show`, `#edit`, `#update`, and `#destroy`).
* You DON'T need to implement fully-functioning views, but you can if you want to.
* Take advantage of the <a href="https://github.com/thoughtbot/factory_girl_rails" target="_blank">factory_girl_rails</a> and <a href="https://github.com/ffaker/ffaker" target="_blank">ffaker</a> gems to define an `item` factory to use in your tests.
* Once you have passing specs for your `ItemsController`, it's time for another unit test:
  * Products should have an instance method called `#sell_through` that calculates the sell-through rate (items sold / total items).
  * **Write the spec for `#sell_through` before implementing the method!**

Feel free to reference the [solution_items branch](https://github.com/sf-wdi-24/testing_inventory/tree/solution_items) for guidance.

## Resources

* <a href="https://github.com/rspec/rspec-rails" target="_blank">RSpec Rails Docs</a>
* <a href="https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs" target="_blank">RSpec Controller Specs</a>
* <a href="https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers" target="_blank">RSpec Built-In Matchers</a>
* <a href="https://github.com/thoughtbot/factory_girl_rails" target="_blank">Factory Girl Rails Docs</a>
* <a href="https://github.com/ffaker/ffaker" target="_blank">FFaker Docs</a>
* <a href="http://ricostacruz.com/cheatsheets/ffaker.html" target="_blank">FFaker Cheatsheet</a>
* <a href="http://guides.rubyonrails.org/routing.html#nested-resources" target="_blank">Rails Nested Resources</a>
