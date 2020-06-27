xml.instruct!
xml.backgrounds do
  @backgrounds.each do |bg|
    xml.background do
      xml.id bg.id
      xml.name bg.name
      xml.url bg.url
      xml.comment bg.comment
      xml.created_at bg.created_at
      xml.updated_at bg.updated_at
    end
  end
end