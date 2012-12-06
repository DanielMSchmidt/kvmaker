class KvsController < ApplicationController
  # GET /kvs
  # GET /kvs.json
  def index
    @kvs = Kv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kvs }
    end
  end

  # GET /kvs/1
  # GET /kvs/1.json
  def show
    @kv = Kv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kv }
    end
  end

  # GET /kvs/new
  # GET /kvs/new.json
  def new
    @kv = Kv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kv }
    end
  end

  # GET /kvs/1/edit
  def edit
    @kv = Kv.find(params[:id])
  end

  # POST /kvs
  # POST /kvs.json
  def create
    @kv = Kv.new(params[:kv])

    respond_to do |format|
      if @kv.save
        format.html { redirect_to @kv, notice: 'Kv was successfully created.' }
        format.json { render json: @kv, status: :created, location: @kv }
      else
        format.html { render action: "new" }
        format.json { render json: @kv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kvs/1
  # PUT /kvs/1.json
  def update
    @kv = Kv.find(params[:id])

    respond_to do |format|
      if @kv.update_attributes(params[:kv])
        format.html { redirect_to @kv, notice: 'Kv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kvs/1
  # DELETE /kvs/1.json
  def destroy
    @kv = Kv.find(params[:id])
    @kv.destroy

    respond_to do |format|
      format.html { redirect_to kvs_url }
      format.json { head :no_content }
    end
  end
end
