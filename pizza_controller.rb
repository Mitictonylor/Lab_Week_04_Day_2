require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('./models/pizza_order')
require_relative('./models/customer')
also_reload('./models/*')


# INDEX
get '/pizzas' do
  @orders = PizzaOrder.all()
  erb(:index)
end

# NEW
get '/pizzas/new' do
  @customers = Customer.all()
  erb(:new)
end

# SHOW
get '/pizzas/:id' do
  id = params['id'].to_i()
  @order = PizzaOrder.find(id)
  erb(:show)
end

# CREATE

post '/pizzas' do
  new_order = PizzaOrder.new(params)
  new_order.save()
  erb(:create)
end

post '/pizzas/:id/delete' do
  id = params['id'].to_i()
  order = PizzaOrder.find(id)
  order.delete()
  redirect('/pizzas')
end

get '/pizzas/:id/edit' do
  id = params['id'].to_i
  @order = PizzaOrder.find(id)
  @customers = Customer.all()
  erb(:edit)
end

post '/pizzas/:id' do
  order = PizzaOrder.new(params)
  order.update()
  redirect('/pizzas/' + params['id'])
end
