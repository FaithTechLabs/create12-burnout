class SurveyController < ApplicationController
  def questions
    @questions = Question.all
  end

  def show
    hash_id = params[:hash_id]
    @survey = Survey.find_by(hash_id: hash_id)
    @questions_by_id = Question.all.index_by(&:id)

    return render plain: "Survey not found", status: :not_found if @survey.nil?
    return render plain: "Survey completed", status: :gone if @survey.completed?

    #render json: survey
  end

  def update
  end

  private
  def update_params
    params[:answers] # this will be an array
  end
end
