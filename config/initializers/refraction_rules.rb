Refraction.configure do |req|
  if req.host == 'localcycle.org'
    req.rewrite! "https://www.localcycle.org/#{req.path}"
  end
end