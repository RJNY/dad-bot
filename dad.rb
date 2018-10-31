require 'slack-ruby-bot'
require 'httparty'

class Dad < SlackRubyBot::Bot
  help do
    title 'Dad Jokes'
    desc 'Tells only the finest jokes'

    command 'dadjoke' do
      desc 'will tell a random joke.'
    end
  end

  command('dadjoke') do |client, data, match|
    client.say(channel: data.channel, text: joke)
  end

  def joke
    response = HTTParty.get('https://icanhazdadjoke.com/slack', format: :plain)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:attachments][0][:text]
  end
end

Dad.run
