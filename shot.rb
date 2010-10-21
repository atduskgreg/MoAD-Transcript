require 'yaml'

class Shot
  attr_accessor :time_code, :description, :image_url, :notes, :transition_out, :additional_images, :time_offset
  
  def self.load_all(path_to_yml)
    @raw_timeline = YAML.load(open("moad_transcription.yml").read)
    @raw_timeline["Shots"].collect do |s|
      shot = self.new(s)
      shot.parse_time!
      shot
    end
  end
  
  def parse_time!
    parts = self.time_code.split(":")
    hours = parts[0].to_i
    minutes = parts[1].to_i
    seconds = parts[2].to_i
    @time_offset = seconds + (minutes * 60) + (hours * 60 * 60)
  end
  
  def initialize(yml_node)
    yml_node.keys.each do |k|
      self.send("#{k}=".to_sym, yml_node[k])
    end
    
  end
end
