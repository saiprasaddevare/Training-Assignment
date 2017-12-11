class RecordsController < ApplicationController
  # skip_before_action :verify_authenticity_token

resource_description do
  short 'Create, Update, Delete the Student'
end

def_param_group :type_validate do
   description <<-EOS
    ==Description
    Enter Valid type of Data to do the operation
  EOS
end

def_param_group :error_code do
  error 500, "Internal Server Error"
  error 404, "User Profile not yet created"
end  

api! 'GET all'
param :id, String, "By default Available",:required => true
description <<-EOS
==Description 
  The id is used to find all student details from the tables. 
EOS
param_group :error_code
def index
  cleaned_json = clean_json Record.all 
  render json: cleaned_json 
end

api! 'GET the last added student'
param :id, String, "By default Available",:required => true
description <<-EOS
==Description
  Add the recent record to the database. 
EOS
param_group :error_code
def last
  render json: clean_json(Record.last) 
end

api! 'POST a new student into students'
param :Name, String, :required => true
param :Grade, Integer, :required => true
param :Roll, Integer, :required => true
param_group :type_validate
param_group :error_code
header 'X-CSRF-Token', 'Avoid CSRF request to hack the application under your privilages'
def create
  Record.create(verify_params)
end

api! 'UPDATE a student record using id'
param :id, String, "Value is available at time of Updation", :required => true  
param :Name,  String, :required => true
param :Grade, Integer, :required => true
param :Roll, Integer, :required => true
param_group :type_validate
param_group :error_code
def update
  record =  Record.find_by(id: verify_params[:id])
  record.update(name: verify_params[:name]) 
  record.update(grade: verify_params[:grade])
  record.update(roll: verify_params[:roll])
  render json: {} 
end

api! 'DELETE a student record using id' 
param :id, String, "by default available at time of deletion",:required => true
description <<-EOS
  ==Description
  Delete the record by using id.
EOS
param_group :error_code
def destroy
  Record.find_by(id: verify_params[:id]).destroy
end

  private

  # permit only the data which has all four fields filled.
  def verify_params
    # since I am passing id to the html page
    params.permit(:name, :grade, :roll, :id)
  end

  # records is a Criteria or Record object
  def clean_json records
   json_data = records.as_json # this is as_json method of Mongoid::Criteria class 

    if json_data.class == Array # if the json data is an array
      json_data.each do |row|
        row["id"] = row.delete "_id" # this is to make sure angular recognizes @id when sending requests
      end
    else
      json_data["id"] = json_data.delete "_id" # if the json_data is not an array
      end

    json_data
  end
end
