logfile = "#{Rails.root}/lib/checked.log.txt"

File.readlines(logfile).each do |line|
  results = line.scan(/(^|\s)(@|＠)(\w+)/)
  next if results.size.zero?
  
  name = results[0].join('').strip.gsub('@', '')
  next if name.nil?
  # /(?:^|[\s　]+)((?:https?|ftp):\/\/[^\s　]+)/
  url = line.scan(/(?:^|[\s　]+)((?:https?|ftp):\/\/[^\s　]+)/).flatten[0]
  next if url.nil? || url.empty?
  tweet_id = url.split('/').last

  content = line.gsub(/(^|\s)(@|＠)(\w+)|(?:^|[\s　]+)((?:https?|ftp):\/\/[^\s　]+)|(["“][.+]["”])/u, '').gsub(/((RT|ＲＴ)(:|：|\s))|(^|\s)((RT|ＲＴ)(:|：|\s))(.+|\s)[^\x01-\x7E].+/u, '').strip
  next if content.nil? || content.empty?

  user = User.where(name: name).first_or_create{ |user| user.name = name }
  Entry.create(user: user, content: content, source_url: url, tweet_id: tweet_id)
end