require 'rubygems'
require 'oauth'
require 'yaml'
require 'json'

config = YAML.load_file('config/oauth.yml')

oauth_options = config['linkedin-example']

consumer_options = { :site => oauth_options['api_host'],
                     :authorize_path => oauth_options['authorize_path'],
                     :request_token_path => oauth_options['request_token_path'],
                     :access_token_path => oauth_options['access_token_path'] }

consumer = OAuth::Consumer.new(oauth_options['consumer_key'], oauth_options['consumer_secret'], consumer_options)
ARGV.push('c59dae83-4c24-47c4-a2be-4d09674cfc2c')
ARGV.push('c024d26a-45fa-41a5-b134-afd0c67463c9')
access_token = OAuth::AccessToken.new(consumer, ARGV[0], ARGV[1])

# Output

# Pick some fields
fields = ['first-name', 'last-name', 'headline', 'industry', 'num-connections'].join(',')
# Make a request for JSON data
json_txt = access_token.get("/v1/people/~:(#{fields})", 'x-li-format' => 'json').body
profile = JSON.parse(json_txt)
puts "Profile data:"
puts JSON.pretty_generate(profile)