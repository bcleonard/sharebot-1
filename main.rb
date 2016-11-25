require('json')
require('googl')

GOOGLE_API_KEY = ARGV[0]
IP = ARGV[1]

loop do
        input = gets

        msg = JSON.parse(input)
        sender = msg["opts"]["sender"]["id"]
        begin
                url = msg["message"]["attachments"][0]["payload"]["url"]
                short = Googl.shorten(url, IP, GOOGLE_API_KEY)
                out = {recipient: sender, message: "Here's your link: #{short.short_url}"}.to_json
                $stdout.puts out
                $stdout.flush
        rescue Exception => e
                $stderr.puts e.inspect
                out = {recipient: sender, message: "Send file to me, and I will give you a public URL for you to share to the world."}.to_json
                $stdout.puts out
                $stdout.flush
        end
end
