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

  command('tell me a joke') do |client, data, match|
    response = JSON.parse(HTTParty.get('https://icanhazdadjoke.com/slack', format: :plain), symbolize_names: true)
    joke = response[:attachments][0][:text]

    client.web_client.chat_postMessage(
      channel: data.channel,
      as_user: true,
      attachments: [
        "fallback": joke,
        "pretext": joke
      ]
    )
  end
end

Dad.run
