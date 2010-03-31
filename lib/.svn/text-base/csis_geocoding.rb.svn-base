#!/usr/bin/ruby -Ku
require 'open-uri'
require 'cgi'
require 'rexml/document'
require 'kconv'

module CSIS

  SERIES_ADDRESS = 'ADDRESS'
  SERIES_STATION = 'STATION'
  SERIES_PLACE = 'PLACE'
  SERIES_FACILITY = 'FACILITY'

class Candidate
  def initialize(e)
    @address = e.get_text('address').value
    @longitude = e.get_text('longitude').value
    @latitude = e.get_text('latitude').value
    @i_lvl = e.get_text('iLvl').value
  end
  attr_reader :address, :longitude, :latitude, :i_lvl
end

class Geocoding
  include REXML
  def initialize(query, series = SERIES_ADDRESS)
    doc = Document.new(open("http://geocode.csis.u-tokyo.ac.jp/cgi-bin/simple_geocode.cgi?" +
                            "addr=#{CGI.escape(query)}&series=#{series}&charset=UTF8"))
    @i_conf = doc.root.get_text('iConf').value
    @candidates = []
    doc.root.each_element('candidate') do |e|
      @candidates << Candidate.new(e)
    end
  end

  attr_reader :i_conf, :candidates
end

end

if $0 == __FILE__
  if ARGV.length == 0
    puts 'usage: ruby csis_geocoding.rb query-word'
    exit(1)
  end
  conv = RUBY_PLATFORM =~ /mswin/ ? 'tosjis' : 'toeuc'
  g = CSIS::Geocoding.new(ARGV[0].toutf8)
  puts "iConf=#{g.i_conf}"
  g.candidates.each do |x|
    puts "address=#{x.address.send(conv)}"
    puts "longitude=#{x.longitude}, latitude=#{x.latitude}"
    puts "iLvl=#{x.i_lvl}"
  end
  puts 'CSISシンプルジオコーディング実験（街区レベル位置参照情報）による'
end
