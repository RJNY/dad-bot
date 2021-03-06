require 'slack-ruby-bot'
require 'httparty'

class DadBot < SlackRubyBot::Bot
  help do
    title 'Dad Jokes'
    desc 'Tells only the finest jokes'

    command 'dad tell me a joke' do
      desc 'will tell a random joke.'
    end

    command 'dad are you there?' do
      desc 'dad-bot will acknowledge you. Finally, approval is only a few keystrokes away!'
    end

    command 'good/nice one dad' do
      desc 'Give dad-bot some credit every now and then. He will appreciate it!'
    end

    command 'hi/hey/hello/sup dad' do
      desc 'Give dad-bot some credit every now and then. He will appreciate it!'
    end
  end

  command(/tell (me|us) a joke/i) do |client, data, match|
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

  command(/(are )?you there\?/i) do |client, data, match|
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

  match(/^(hi|hey|hello|sup) dad/i) do |client, data, match|
    response = "Hey there sport!"
    client.web_client.chat_postMessage(
      channel: data.channel,
      as_user: true,
      attachments: [
        "fallback": response,
        "pretext": response
      ]
    )
  end

  match(/^(good|nice) one dad/i) do |client, data, match|
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
end

DadBot.run
