require './plans.rb'

Plan.all.each do |p|

  p.link = p.title.strip.gsub('<h1>', '').gsub('</h1>', '').gsub(' ', '-').downcase

  if p.link
    link = p.link.gsub(':', '')
    link = link.gsub('/', '-')
    link = link.gsub('"', '')
    link = link.gsub("'", '')
    link = link.gsub(',', '')
    link = link.gsub('.', '')
    p.link = link
    p.save
    puts link
  end

end
