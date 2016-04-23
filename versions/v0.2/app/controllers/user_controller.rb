class UserController < Sinatra::Base
  set :root, "#{__dir__}/.."

  get'/' do
    "what"
  end

  get '/users' do
    File.read('site/users/index.html')
  end

  get '/users/:name' do
    create_read = 'site/users/' + params[:name] + '.html'
    File.read(create_read)
  end

  get '/:name.html' do
    create_read = 'site/users/' + params[:name] + '.html'
    File.read(create_read)
  end
end
