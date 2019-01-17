class PregnancyWeeksInfo::Week

  attr_accessor :weightUS, :weightMetric, :fruit, :weeks_left, :url, :readings, :symptoms, :readings

  @@all = []

  def self.new_from_page(link, wk)

    alt_tags = wk.css('.wbw-hero__circles__fruit img').map{ |i| i['alt'] }

    self.new(wk.css("#sizeUs").text,
             wk.css("#sizeMetric").text,
             alt_tags.first,
             wk.css(".wbw-hero__circles__weeks__circle__text").first.text, link)
  end

  def initialize(weightUS=nil, weightMetric=nil, fruit=nil, weeks_left=nil, url=nil)
    @weightUS = weightUS
    @weightMetric = weightMetric
    @fruit = fruit
    @weeks_left = weeks_left
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(id)
    self.all[id-2]
  end

  def symptoms
    @symptoms ||= doc.css(".wbw-symptoms__list__item__body-c__headline").map { |symptom| symptom.text }
  end

  def readings
    @readings ||= doc.css(".trending__c__list__item__title").map { |reading| reading.text }
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

end
