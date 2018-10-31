require 'slack-ruby-bot'
require 'httparty'

class Dad < SlackRubyBot::Bot
  help do
    title 'Dad Jokes'
    desc 'Tells only the finest jokes'

    command 'tell me a joke' do
      desc 'will tell a random joke.'
    end

    command 'you there?' do
      desc 'dad will acknowledge you. Finally, approval is only a few keystrokes away!'
    end

    command 'good one dad' do
      desc 'Give dad some credit every now and then. He will appreciate it!'
    end
  end

  command('you there?') do |client, data, match|
    response = "I'm right here pal."
    client.web_client.chat_postMessage(
      channel: data.channel,
      as_user: true,
      attachments: [
        "fallback": response,
        "pretext": response
      ]
    )
  end

  scan(/good one dad/) do |client, data, match|
    response = "Thanks champ!"
    client.web_client.chat_postMessage(
      channel: data.channel,
      as_user: true,
      attachments: [
        "fallback": response,
        "pretext": response
      ]
    )
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
