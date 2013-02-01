class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/new
  # GET /searches/new.json
  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/1/edit
  def edit
    @search = Search.find(params[:id])
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(params[:search])

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /searches/1
  # PUT /searches/1.json
  def update
    @search = Search.find(params[:id])

    respond_to do |format|
      if @search.update_attributes(params[:search])
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :ok }
    end
  end
  
  def process_all
    
    #carga todas las busquedas

    Search.all.each do |s|
      logger.info s.process 
    end
    raise "finish"
  end
  
  def terminator
    while true
      self.process_all
      self.launch_senders
    end
  end
  
  attr_accessor :normal_tweets
  # test method for call launch_senders from console w/o create controller
=begin
  def self.ls
    sc = self.new
    sc.launch_senders
  end

  ## this method was moved to account.rb
  def launch_senders
    accounts = Account.all
    replies = SearchesResult.select([:id, :reply]).to_sent # .limit 36
    self.normal_tweets = File.readlines("vendor/normal.txt").map { |i| SearchesResult.new({:reply => i}) }
    mutex = Mutex.new

    threads = []
    accounts.each do |a|
      puts "Lanzando account... #{a.username}"
      threads << Thread.new {
        puts "\r\ndentro de thread, por enviar: #{replies.count}"
        until replies.empty?
          puts " UNTIL  #{a.username}"
          to_send = []
          mutex.synchronize do
            puts "entrando a semaforo #{a.username}"
            to_send = replies.slice!(0..4) + self.normal_tweets.sample(4)
          end
          puts " @#{a.username}: #{to_send.map(&:id).join(', ')}"
          to_send.shuffle.each do |sr|
            sr.account = a
            sr.tweet_it #_test
            sleep(rand(1..3).seconds) #80..200
          end
          sleep 0.1
        end
        puts "Finished thread #{a.username}"
      }
    end
    puts threads.join
  end
=end

end
