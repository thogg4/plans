require 'mechanize'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'plans'
)

class Plan < ActiveRecord::Base

end

@m = Mechanize.new

home_page = @m.get('http://ana-white.com/plancatalog')

@links = []

def harvest_plan_links(current_page)
  @links.push(get_links_from_page(current_page)).flatten!
  next_button = current_page.parser.css('.view-all-plans .pager-next > a').first
  if next_button
    harvest_plan_links(@m.get(next_button.attribute('href').value))
  end
end


def get_links_from_page(page)
  page.parser.css('.views-fluid-grid-list .views-field-title > .field-content > a').map do |l|
    "http://ana-white.com#{l.attribute('href').value}"
  end
end


def harvest_plan(page)
  puts 'harvest plan'
  title = page.search('.tangle h1').first.to_s
  return true if Plan.find_by_title(title)
  summary = page.search('.field-field-summary').first.to_s
  supplies = page.search('.group-supplies').first.to_s
  cutlist = page.search('.group-cutlist').first.to_s
  instructions = page.search('.group-generalinstructions').first.to_s
  steps = ''
  page.search('//div[starts-with(@class, "fieldgroup group-step")]').each { |x| steps += x.to_s if x }
  image = page.search('.field-field-finishedphoto img').attr('src').value
  puts title
  Plan.create(:source_link => page.uri.to_s, :title => title, :summary => summary, :supplies => supplies, :cutlist => cutlist, :instructions => instructions, :steps => steps, :image => image)
  link_iterator
end


def link_iterator
  next_link = @links.pop
  begin
    puts 'begin'
    plan_page = @m.get(next_link)
    harvest_plan(plan_page)
  rescue
    puts "error link: #{next_link}"
    link_iterator
  end
end


puts 'Harvesting plan links'
harvest_plan_links(home_page)

puts 'Iterating through links'
puts @links.size
link_iterator





