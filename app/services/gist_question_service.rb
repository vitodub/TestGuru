class GistQuestionService

  attr_reader :url, :gist_created

  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client
    @url = nil
    @gist_created = nil
  end

  def call
    result = @client.create_gist(gist_params)
    @url = result.html_url
    @gist_created = success?
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

  def success?
    @client.last_response.status == 201
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
