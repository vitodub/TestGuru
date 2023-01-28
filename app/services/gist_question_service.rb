class GistQuestionService

  # Подсмотрел у ребят часть решения со Struct. Можешь объяснить поподробнее, почему лучше использовать его?
  GistResult = Struct.new(:gist_url, :success?)

  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    result = @client.create_gist(gist_params)
    
    # Откуда взялся метод .html_url? В документации я его не нашел
    GistResult.new(result.html_url, success?)    
  end

  private

  def gist_params
    {
      description: I18n.t('description', test_title: @test.title ),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def default_client
    Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'])
  end

  # В логах терминала вижу только код 300 и 200. Откуда берется 201? Или я не там смотрю? 
  # Также в документации видел метод .last_response. Где искать .last_response.status?
  def success?
    @client.last_response.status == 201
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
