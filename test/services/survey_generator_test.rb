require "test_helper"

class SurveyGeneratorTest < ActiveSupport::TestCase
  test "generates a survey for a given user" do
    user = users(:bob)
    survey = SurveyGenerator.generate_for_user(user)

    assert_equal user, survey.user
  end

  test "generates a survey with a sampling of questions from each category" do
    user = users(:bob)
    survey = SurveyGenerator.generate_for_user(user)

    question_category_count = Question::CATEGORIES.keys.index_with(0)
    survey.answers.each do |answer|
      category = answer.question.category.downcase.to_sym
      assert question_category_count.key?(category)
      question_category_count[category] += 1
    end

    expected_count_from_each_category = 2
    question_category_count.each do |category, count|
      assert_equal expected_count_from_each_category, count,
        "Incorrect number of questions from category: #{category}"
    end
  end
end
