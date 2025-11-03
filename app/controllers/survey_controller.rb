class SurveyController < ApplicationController
  def questions
    @questions = Question.all
  end
end
