class SurveyController < ApplicationController
  def questions
    @questions = Question.all
  end

  def show
    hash_id = params[:hash_id]
    survey = Survey.find_by(hash_id: hash_id)

    return render plain: "Survey not found", status: :not_found if survey.nil?
    return render plain: "Survey completed", status: :gone if survey.completed?

    render json: survey
  end
end
