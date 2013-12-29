class AccountsController < ApplicationController
	# GET /accounts
	# GET /accounts.json
	def index
		@accounts = Account.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @accounts }
		end
	end
  
  def get_all_timeline
    Account.all.each do |a| 
      a.get_timeline
    end
    raise "finalizado"
    
  end
  
	# METODO CALLBACK
	def save_tokens
		@account = Account.find_by_username request.env['omniauth.auth']['info']['nickname']

    @account.uid = request.env['omniauth.auth']['uid']
		@account.token = request.env['omniauth.auth']['credentials']['token'] 
		@account.token_secret = request.env['omniauth.auth']['credentials']['secret'] 
		@account.save

		redirect_to accounts_url

	end

	# GET /accounts/1
	# GET /accounts/1.json
	def show
		@account = Account.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @account }
		end
	end

	# GET /accounts/new
	# GET /accounts/new.json
	def new
		@account = Account.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @account }
		end
	end

	# GET /accounts/1/edit
	def edit
		@account = Account.find(params[:id])
	end

	# GET /accounts/1/follow/1
	def follow
		@account = Account.find(params[:id])
		@account.follow(params[:user])
		respond_to do |format|
			format.html { redirect_to root_path, notice: 'User followed successfully.' }
		end
	end

	# POST /accounts
	# POST /accounts.json
	def create
		@account = Account.new(params[:account])

		respond_to do |format|
			if @account.save
				# If we provide tokens (manually)
				if !@account.tokens?
					redirect_to '/auth/twitter?screen_name=' + @account.username
					return
				else
					format.html { redirect_to @account, notice: 'Account was successfully created.' }
					format.json { render json: @account, status: :created, location: @account }	
				end
			else
				format.html { render action: "new" }
				format.json { render json: @account.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /accounts/1
	# PUT /accounts/1.json
	def update
		@account = Account.find(params[:id])

		respond_to do |format|
			if @account.update_attributes(params[:account])
				format.html { redirect_to @account, notice: 'Account was successfully updated.' }
				format.json { head :ok }
			else
				format.html { render action: "edit" }
				format.json { render json: @account.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /accounts/1
	# DELETE /accounts/1.json
	def destroy
		@account = Account.find(params[:id])
		@account.destroy

		respond_to do |format|
			format.html { redirect_to accounts_url }
			format.json { head :ok }
		end
	end
end


