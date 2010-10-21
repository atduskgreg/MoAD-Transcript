# TODO:
# - find the parsed shot closest to the time stamp but before it
# - insert the transcription into the yml

require 'shot'

path_to_transcription = ARGV[0]


t = open(path_to_transcription).read

parts = t.split(/([0-9]+:[0-9]+)/)

class Moment
  attr_accessor :time_string, :text, :time_offset
  
  def parse_time!
    parts = time_string.split(":")
    minutes = parts.first.to_i
    seconds = parts.last.to_i
    self.time_offset = seconds + (minutes * 60)
  end
end

moments = []

parts.each_with_index do |l,i|  
  if l =~ /([0-9]+:[0-9]+)/
    m = Moment.new
    m.time_string = l
    moments << m
  else
    l.slice!(0)
    l.reverse.slice!(0)
    l.slice!(l.length-1)
    if moments.length > 0
      moments.last.text = l
    else
      m = Moment.new
      m.time_string = "0:00"
      m.text = l
      moments << m
    end
  end
end

moments = moments.collect{|m| m.parse_time!; m}

puts moments.inspect
puts moments.first.time_string
puts moments.first.text

shots = Shot.load_all

moments.each do |m|
end