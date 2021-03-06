module ExternalContent
  def self.included(target)
    target.class_eval do
      validates_presence_of :poster_id
      validates_length_of :url, in: 1..2048
      validates :description,
                :length => { :maximum => 256 },
                :allow_blank => true
      validates_format_of( :url,
                   with: /^((http|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/,
                   message: "Invalid link format",
                   allow_blank: true)
    end
  end
end
