require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

def save_registration_report(form_targeting)
  Dir.mkdir("report") unless Dir.exists? "report"

  filename = "report/reg_report_#{Time.now.strftime('%d-%m-%y')}.html"

  File.open(filename, "w") do |file|
    file.puts form_targeting
  end
end

def clean_phone_number(home_phone)
  home_phone = home_phone.to_s.gsub(/[^\d]/, "")
  if home_phone.length == 11 && home_phone[0] != 1
    home_phone[1..10]
  elsif home_phone.length == 10
    home_phone
  else
    "Invalid number."
  end
end

def date_parser(reg_date)
  DateTime.strptime(reg_date, '%m/%d/%y %H:%M')
end

def generate_thank_you_letters(contents)

  template_letter = File.read "form_letter.erb"
  erb_template = ERB.new template_letter

  contents.each do |row|
    id = row[0]
    name = row[:first_name]

    zipcode = clean_zipcode(row[:zipcode])

    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letters(id, form_letter)
  end
end

def mobile_alerts
  contents.each do |row|
    id = row[0]
    name = row[:first_name]

    home_phone = clean_phone_number(row[:homephone])
  end
end

puts "Event Manager Initialized!"

contents = CSV.open "event_attendees.csv",
            headers: true, header_converters: :symbol

template_report = File.read "form_targeting.erb"
erb_template = ERB.new template_report

reg_times = Hash.new(0)
reg_days = Hash.new(0)

contents.each do |row|
  reg_date = date_parser(row[:regdate])

  reg_times[reg_date.strftime("%l %P")] += 1
  reg_days[reg_date.strftime("%a")] += 1

  form_targeting = erb_template.result(binding)

  save_registration_report(form_targeting)
end
