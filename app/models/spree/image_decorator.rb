Spree::Image.class_eval do

  # Forces ssl for amazon s3 images
  if Spree::Config[:use_s3]
    Spree::Image.attachment_definitions[:attachment][:s3_protocol] = 'https'
  end

  attachment_definitions[:attachment][:styles] = {
    # images under thumb
    :mini => {
      :geometry => '48x48>',
      :format => 'jpg',
      :convert_options => '-quality 80 -strip'
    },
    # images on category view
    :small => {
      :geometry => '100x100>',
      :format => 'jpg',
      :convert_options => '-quality 80 -strip'
    },
    # images in grids
    :product => {
      :geometry => '180x150#',
      :format => 'jpg',
      :convert_options => '-quality 80 -strip'   # if ever need to crop top instead of center add this -crop 180x150+0+0'
    },
    # big image on product details page
    :large => {
      :geometry => '400x400#',
      :format => 'jpg',
      :convert_options => '-quality 80 -strip'
    }
  }
end