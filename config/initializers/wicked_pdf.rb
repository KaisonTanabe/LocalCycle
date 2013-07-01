if Rails.env.staging? || Rails.env.production?
  WickedPdf.config = {:exe_path => Rails.root.join('bin', 'wkhtmltopdf').to_s}
else
  WickedPdf.config = {:exe_path => "bin/wkhtmltopdf"}
end
