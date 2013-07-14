# !/usr/bin/env ruby

logfile = '/Users/otiashee/Develop/Rails/takawo_checker_2/log/checked.log.txt'
# logfile = 1 == ARGV.length ? ARGV[0] : ARGV[ARGV.index('-f') + 1]
abort 'file not found' if !logfile

res = []
File.readlines(logfile).each do |line|
  results = line.scan(/(^|\s)(@|＠)(\w+)/)
  next if results.size.zero?
  
  name = results[0].join('').strip
  next if name.nil?
  # /(?:^|[\s　]+)((?:https?|ftp):\/\/[^\s　]+)/
  url = line.scan(/(?:^|[\s　]+)((?:https?|ftp):\/\/[^\s　]+)/).flatten[0]
  next if url.nil? || url.empty?

  content = line.gsub(/(^|\s)(@|＠)(\w+)|(?:^|[\s　]+)((?:https?|ftp):\/\/[^\s　]+)|(["“][.+]["”])/u, '').gsub(/((RT|ＲＴ)(:|：|\s))|(^|\s)((RT|ＲＴ)(:|：|\s))(.+|\s)[^\x01-\x7E].+/u, '').strip
  next if content.nil? || content.empty?
  res << "name: #{name} content: #{content} url: #{url}"

  # @user = User.where(name: name).first_or_create{ |user| user.name = name }
  # Entry.create(user: user, content: content, source_url: url)
end

puts res