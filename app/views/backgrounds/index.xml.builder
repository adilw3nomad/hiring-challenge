xml.instruct!
xml.backgrounds do
  @backgrounds.each do |bg|
    render(:partial => 'record.xml.builder', :locals => {:builder => xml, :background => bg })
  end
end