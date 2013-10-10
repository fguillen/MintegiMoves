Paperclip.interpolates :picable_id do |attachment, style|
  attachment.instance.picable_id
end

Paperclip.interpolates :picable_type do |attachment, style|
  attachment.instance.picable_type.downcase
end