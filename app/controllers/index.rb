get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/username' do
  p params
  p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

  @user = User.find_by_username(params[:username])

  # raise params.inspect

  if @user && @user.tweets_fresh? #if user is not nil
    @user
    erb :_index, :locals => { :object => @user}
  elsif @user 
    @user.tweets.delete_all
    @tweets = Twitter.user_timeline(params[:username])
    @tweets[0..10].each do
      Tweet.create(:user_id => @user.id, :content => @tweets.shift.text)
    end 
    erb :_index, :locals => { :object => @user}
  else  
    @user = User.new(:username => params[:username])
    if @user.save
      @tweets = Twitter.user_timeline(params[:username])

      @tweets[0..9].each do
        Tweet.create(:user_id => @user.id, :content => @tweets.shift.text)
      end
      erb :_index, :locals => { :object => @user}
    else 
      erb :_index, :locals => { :object => @user}
    end
  end  
end




