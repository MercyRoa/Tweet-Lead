class SheduledMessagesController < ApplicationController
  
  def send_messages
    SheduledMessage.send_all
    raise "Terminado"
  end
  
  
  # GET /sheduled_messages
  # GET /sheduled_messages.json
  def index
    @sheduled_messages = SheduledMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sheduled_messages }
    end
  end

  # GET /sheduled_messages/1
  # GET /sheduled_messages/1.json
  def show
    @sheduled_message = SheduledMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sheduled_message }
    end
  end

  # GET /sheduled_messages/new
  # GET /sheduled_messages/new.json
  def new
    @sheduled_message = SheduledMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sheduled_message }
    end
  end

  # GET /sheduled_messages/1/edit
  def edit
    @sheduled_message = SheduledMessage.find(params[:id])
  end

  # POST /sheduled_messages
  # POST /sheduled_messages.json
  def create
    @sheduled_message = SheduledMessage.new(params[:sheduled_message])

    respond_to do |format|
      if @sheduled_message.save
        format.html { redirect_to @sheduled_message, notice: 'Sheduled message was successfully created.' }
        format.json { render json: @sheduled_message, status: :created, location: @sheduled_message }
      else
        format.html { render action: "new" }
        format.json { render json: @sheduled_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sheduled_messages/1
  # PUT /sheduled_messages/1.json
  def update
    @sheduled_message = SheduledMessage.find(params[:id])

    respond_to do |format|
      if @sheduled_message.update_attributes(params[:sheduled_message])
        format.html { redirect_to @sheduled_message, notice: 'Sheduled message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sheduled_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sheduled_messages/1
  # DELETE /sheduled_messages/1.json
  def destroy
    @sheduled_message = SheduledMessage.find(params[:id])
    @sheduled_message.destroy

    respond_to do |format|
      format.html { redirect_to sheduled_messages_url }
      format.json { head :ok }
    end
  end
end
