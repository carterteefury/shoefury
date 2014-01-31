module Spree
  class Brand < ActiveRecord::Base
    attr_accessible :return_policy, :return_days, :shipping_details, :name, :logo, :background, :sizing_chart, :about, :background_color, :primary_text_color, :secondary_text_color, :link_color, :dark_color_scheme, :free_shipping
    validates :name, :presence => true
    validates :background_color, :presence => true, :hex_color => true
    validates :primary_text_color, :presence => true, :hex_color => true
    validates :secondary_text_color, :presence => true, :hex_color => true
    validates :link_color, :presence => true, :hex_color => true
    #validates_attachment_presence :logo
    #validates_attachment_presence :background
    #validates_attachment_presence :sizing_chart
    has_many :users
    has_many :products, :dependent => :destroy

    has_attached_file :logo,
       :styles => { :normal => '200x80>', :mini=>'100x40' },
       :url => '/spree/brands/logos/:id/:style/:basename.:extension',
       :path => ':rails_root/public/spree/brands/logos/:id/:style/:basename.:extension'

    has_attached_file :background,
       :styles => { :normal => '960x680>', :mini=>'100x60'  },
       :url => '/spree/brands/backgrounds/:id/:style/:basename.:extension',
       :path => ':rails_root/public/spree/brands/backgrounds/:id/:style/:basename.:extension'

    has_attached_file :sizing_chart,
       :styles => { :normal => '200x200>', :mini=>'60x60'  },
       :url => '/spree/brands/charts/:id/:style/:basename.:extension',
       :path => ':rails_root/public/spree/brands/charts/:id/:style/:basename.:extension'

    if Spree::Config[:use_s3]
      s3_creds = { :access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket] }
      Spree::Brand.attachment_definitions[:logo][:storage] = :s3
      Spree::Brand.attachment_definitions[:logo][:s3_credentials] = s3_creds
      Spree::Brand.attachment_definitions[:logo][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::Brand.attachment_definitions[:logo][:bucket] = Spree::Config[:s3_bucket]
      Spree::Brand.attachment_definitions[:logo][:s3_protocol] = 'https'

      Spree::Brand.attachment_definitions[:background][:storage] = :s3
      Spree::Brand.attachment_definitions[:background][:s3_credentials] = s3_creds
      Spree::Brand.attachment_definitions[:background][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::Brand.attachment_definitions[:background][:bucket] = Spree::Config[:s3_bucket]
      Spree::Brand.attachment_definitions[:background][:s3_protocol] = 'https'

      Spree::Brand.attachment_definitions[:sizing_chart][:storage] = :s3
      Spree::Brand.attachment_definitions[:sizing_chart][:s3_credentials] = s3_creds
      Spree::Brand.attachment_definitions[:sizing_chart][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::Brand.attachment_definitions[:sizing_chart][:bucket] = Spree::Config[:s3_bucket]
      Spree::Brand.attachment_definitions[:sizing_chart][:s3_protocol] = 'https'
    end

    # Set defaults
    def initialize(params = nil, options = {})
      super
      self.background_color = "#1A1A1A" unless self.background_color
      self.primary_text_color = "#FFFFFF" unless self.primary_text_color
      self.secondary_text_color = "#9E9E9E" unless self.secondary_text_color
      self.link_color = "#29ABE2" unless self.link_color
      self.dark_color_scheme = true unless self.dark_color_scheme
    end
  
  end
end
