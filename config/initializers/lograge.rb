PARAMS_TO_CLEAN = [
  "action",
  "controller",
  "utf8",
  "authenticity_token"
]

def params(event)
  event.payload[:params].select { |k,v| !PARAMS_TO_CLEAN.include?(k) }
end

Lograge::custom_options = lambda do |event|
  log_hash = {}
  log_hash[:path] = event.payload[:path]
  log_hash[:params] = params(event) if event.payload[:method] != "GET"

  log_hash
end
