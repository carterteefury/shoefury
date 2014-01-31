module Spree
  module Manage
    module NavHelper

      # brand management version of tab navigation
      def mtab(*args)
        options = {:label => args.first.to_s}
        if args.last.is_a?(Hash)
          options = options.merge(args.pop)
        end
        options[:route] ||=  "manage_#{args.first}"

        destination_url = options[:url] || spree.send("#{options[:route]}_path")

        titleized_label = t(options[:label], :default => options[:label]).titleize

        link = link_to(titleized_label, destination_url)

        css_classes = []

        selected = if options[:match_path]
                     # TODO: `request.fullpath` for engines mounted at '/' returns '//'
                     # which seems an issue with Rails routing.- revisit issue #910
                     request.fullpath.gsub('//', '/').starts_with?("#{root_path}manage#{options[:match_path]}")
                   else
                     args.include?(controller.controller_name.to_sym)
                   end
        css_classes << 'selected' if selected

        if options[:css_class]
          css_classes << options[:css_class]
        end
        content_tag('li', link, :class => css_classes.join(' '))
      end
    end
  end
end
