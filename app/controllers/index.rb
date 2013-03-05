get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/username' do
  @user = User.find_by_username(params[:username])

  # raise params.inspect

  if @user && @user.tweets_fresh? #if user is not nil
    @user
    erb :index
  elsif @user 
    # raise @tweets.length.inspect
    @user.tweets.delete_all

    @tweets = Twitter.user_timeline(params[:username])

    @tweets[0..10].each do
      Tweet.create(:user_id => @user.id, :content => @tweets.shift.text)
    end 
    erb :index

  else  
    @user = User.new(:username => params[:username])
    if @user.save
      @tweets = Twitter.user_timeline(params[:username])

      @tweets[0..9].each do
        Tweet.create(:user_id => @user.id, :content => @tweets.shift.text)
      end

      erb :index
    else 
      erb :index
    end
  end  
end

