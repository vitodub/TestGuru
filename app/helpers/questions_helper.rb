module QuestionsHelper
  
  def question_header(question)
    base_phrase = "вопрос для теста #{question.test.title} "
    
    if question.new_record?
      "Создать новый #{base_phrase}"
    else
      "Редактировать #{base_phrase}"
    end
  end
end
