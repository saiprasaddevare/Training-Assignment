class StudentsController < ApplicationController
  # default page. my front page

resource_description do
  short 'List the Student details'
end

  #api 'GET' '/' ,"message"
  api! 'Main_Page Student list'
  description <<-EOS
    ==DESCRIPTION
    This API is for displaying all the CRUD stuff.This is an Single Page Application.
    <br>So all the operation is performed in a single page.
  EOS
  def index
  end
end
