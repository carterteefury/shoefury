class SetBrandColorDefaults < ActiveRecord::Migration
  def up
    #loop and set defaults on existing brands
    Spree::Brand.all.each do |sb|
      sb.background_color = "#1A1A1A"
      sb.primary_text_color = "#FFFFFF"
      sb.secondary_text_color = "#9E9E9E"
      sb.link_color = "#29ABE2"
      sb.dark_color_scheme = true
      sb.save
    end

  end
end
