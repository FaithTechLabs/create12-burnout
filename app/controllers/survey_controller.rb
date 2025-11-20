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
    # 1. Find the Survey using the hash_id from the URL
    @survey = Survey.find_by!(id: params[:id])
    
    # We load the questions hash again in case we need to re-render the form on error
    @questions_by_id = Question.all.index_by(&:id) 

    # Use a database transaction to ensure atomicity: 
    # If the update fails, the mailer is not sent.
    ActiveRecord::Base.transaction do
      
      # 2. Attempt to update the Survey and all nested Answer records
      puts "--DEBUG-- Got into DB transaction. Survey Id: #{@survey.id}"
      if @survey.update(update_params)
        
        puts "--DEBUG-- Params worked?" 
        # 3. SUCCESS: Fire the Mailer
        # Use deliver_later to send the email in the background, keeping the app responsive.
        SurveyMailer.survey_complete(@survey).deliver_later
        
        # 4. Redirect the user
        redirect_to survey_path(@survey), notice: "Survey successfully submitted. A confirmation email is being sent shortly."
      
      else
        # 5. FAILURE: Render the form again with validation errors
        # The @survey object will now contain the validation errors.
        
        # NOTE: We use render :edit because the form logic is in the 'edit' view, 
        # and we must pass the status :unprocessable_entity (422) for standard API practice.
        render :edit, status: :unprocessable_entity 
      end
      
    end # End of transaction
    
  rescue ActiveRecord::RecordNotFound
    # Handle case where the hash_id is invalid
    redirect_to root_path, alert: "Survey not found or link is invalid."


  end

  private
  def update_params
    params.require(:survey).permit(
      # 1. Direct Survey Attributes (add any fields like :title, :user_email here)
      # :title,
      
      # 2. CRITICAL: Nested Attributes
      answer_attributes: [
        :id,             # REQUIRED to identify and update the existing Answer record
        :answer,         # The field receiving the radio button value (1-5)
        :question_id     # The ID of the associated Question (essential for context)
        # :survey_id     # Not needed, Rails handles this automatically
      ]
    )
  end
end
