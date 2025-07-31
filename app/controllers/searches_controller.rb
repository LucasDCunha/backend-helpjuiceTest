class SearchesController < ApplicationController
  def index
    @popular_searches = SearchQuery.group(:text).order('count_id DESC').count(:id)
  end

  def create
    ip = request.remote_ip
    session = UserSession.find_or_create_by(ip: ip)

    new_text = params[:text].to_s.strip
    return redirect_to root_path if new_text.blank?

    last_search = session.search_queries.last

    if last_search &&
      new_text.start_with?(last_search.text) &&
      last_search.created_at > 30.seconds.ago

      last_search.update(text: new_text)
    else
      session.search_queries.create(text: new_text)
    end

    redirect_to root_path
  end
end
