class SurveyController < ApplicationController
  def questions
    @questions = Question.all
  end

  def show
    hash_id = params[:hash_id]
    @survey = Survey.find_by(hash_id: hash_id)

    return render plain: "Survey not found", status: :not_found if @survey.nil?
    return render plain: "Survey completed", status: :gone if @survey.completed?
  end

  def update
    @survey = Survey.find_by!(id: params[:id])
    @survey.answered_at = Time.now
    @survey.assign_attributes(update_params)
    @survey.save!
    SurveyMailer.with(survey: @survey).survey_complete.deliver_later
    redirect_to survey_path(@survey.hash_id), notice: "Survey successfully submitted. A confirmation email is being sent shortly."
  end

  private
  def update_params
    params.require(:survey).permit(
      answers_attributes: [
        :id,
        :answer,
      ]
    )
  end
end
