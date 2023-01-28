module GistsHelper
  
  def sliced_ref(gist)
    ref = gist.question.body.truncate(25)
    link_to ref, admin_question_path(gist.question)
  end

  def hash_ref(gist)
    hash = gist.url.split('/').last
    link_to hash, gist.url, target: '_blank'
  end

end
