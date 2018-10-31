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

  command(/^dadjoke/) do |client, data, match|
    response = HTTParty.get('https://icanhazdadjoke.com/slack', format: :plain)
    attachments = JSON.parse(response.body, symbolize_names: true)[:attachments]
    client.web_client.chat_postMessage(
      channel: data.channel,
      as_user: true,
      attachments: attachments
    )
  end
end

Dad.run
