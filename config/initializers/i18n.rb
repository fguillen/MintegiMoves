# from: http://stackoverflow.com/a/9690449/316700
# raises exception when there is a wrong/no i18n key
if Rails.env.development? || Rails.env.test?
  module I18n
    def self.not_found_translation(*args)
      raise "i18n #{args.first}"
    end
  end

  I18n.exception_handler = :not_found_translation
end