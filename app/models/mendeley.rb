class Mendeley
  def initialize(access_token)
    @http_client = Faraday.new
    @http_client.proxy ENV['http_proxy']
    @http_client.headers['Authorization'] = "Bearer #{access_token}"
    @access_token = access_token
  end

  def self.client
    oauth_client = OAuth2::Client.new(
      ENV['MENDELEY_CLIENT_ID'],
      ENV['MENDELEY_CLIENT_SECRET'],
      site: 'https://api.mendeley.com',
      connection_opts: {
        proxy: {uri: ENV['http_proxy']}
      }
    )
  end

  def self.get_token(code)
    self.client.auth_code.get_token(
      code, grant_type: "authorization_code",
      #redirect_uri: PostRank::URI.clean("#{ENV['ENJU_LEAF_URL']}/#{EnjuLeaf::Engine.routes.url_helpers.page_callback_path}"),
      redirect_uri: ENV['ENJU_LEAF_CALLBACK_URL'],
      scope: 'all'
    ).token
  end

  def self.post(url, options = {}, token)
    conn = Faraday.new do |c|
      c.proxy ENV['http_proxy']
      c.adapter Faraday.default_adapter
    end
    conn.headers["Authorization"] = "Bearer #{token}"
    conn.headers["Content-Type"] = "application/vnd.mendeley-document.1+json"
    conn.post(url, options)
  end

  def folders(group_id)
    url = "https://api.mendeley.com/folders?group_id=#{group_id}"
    JSON.parse(@http_client.get(url).body)
  end

  def document(document_id, view = nil)
    url = "https://api.mendeley.com/documents/#{document_id}?view=#{view}"
    JSON.parse(@http_client.get(url).body)
  end

  def documents(folder_id, limit = 200)
    if folder_id
      url = "https://api.mendeley.com/folders/#{folder_id}/documents?limit=#{limit}"
    else
      url = "https://api.mendeley.com/documents?limit=#{limit}"
    end
    JSON.parse(@http_client.get(url).body)
  end

  def catalog(doi)
    url = "https://api.mendeley.com/catalog?doi=#{doi}"
    JSON.parse(@http_client.get(url).body)
  end

  def link(doi)
    JSON.parse(catalog(doi).body).first.try(:[], "link")
  end

  def http_client
    @http_client
  end
end
